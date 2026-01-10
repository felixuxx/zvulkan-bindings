//! Example program demonstrating zvulkan-bindings usage
//! This creates a Vulkan instance and enumerates physical devices

const std = @import("std");
const vk = @import("zvulkan_bindings");

pub fn main() !void {
    std.debug.print("zvulkan-bindings - Vulkan Bindings for Zig\n", .{});
    std.debug.print("==========================================\n\n", .{});

    // Initialize the Vulkan loader
    std.debug.print("Loading Vulkan library...\n", .{});
    var loader = vk.Loader.init() catch |err| {
        std.debug.print("Failed to load Vulkan: {}\n", .{err});
        std.debug.print("\nMake sure Vulkan is installed on your system:\n", .{});
        std.debug.print("  Linux: Install vulkan-loader package\n", .{});
        std.debug.print("  Windows: Install Vulkan SDK or graphics drivers\n", .{});
        std.debug.print("  macOS: Install Vulkan SDK (MoltenVK)\n", .{});
        return err;
    };
    defer loader.deinit();
    std.debug.print("✓ Vulkan library loaded successfully\n\n", .{});

    // Check Vulkan version
    if (loader.vkEnumerateInstanceVersion) |enumerate_version| {
        var version: u32 = 0;
        const result = enumerate_version(&version);
        if (result == .success) {
            const major = vk.constants.versionMajor(version);
            const minor = vk.constants.versionMinor(version);
            const patch = vk.constants.versionPatch(version);
            std.debug.print("Vulkan API Version: {}.{}.{}\n\n", .{ major, minor, patch });
        }
    }

    // Query available instance extensions
    std.debug.print("Querying available instance extensions...\n", .{});
    var extension_count: u32 = 0;
    _ = loader.vkEnumerateInstanceExtensionProperties.?(null, &extension_count, null);
    std.debug.print("Found {} instance extensions\n\n", .{extension_count});

    // Query available layers
    std.debug.print("Querying available layers...\n", .{});
    var layer_count: u32 = 0;
    _ = loader.vkEnumerateInstanceLayerProperties.?(&layer_count, null);
    std.debug.print("Found {} layers\n\n", .{layer_count});

    // Create Vulkan instance
    std.debug.print("Creating Vulkan instance...\n", .{});
    const app_info = vk.core_1_0.ApplicationInfo{
        .p_application_name = "zvulkan-bindings Example",
        .application_version = vk.constants.makeApiVersion(0, 1, 0, 0),
        .p_engine_name = "No Engine",
        .engine_version = vk.constants.makeApiVersion(0, 1, 0, 0),
        .api_version = vk.constants.makeApiVersion(0, 1, 3, 0),
    };

    const instance_create_info = vk.core_1_0.InstanceCreateInfo{
        .p_application_info = &app_info,
    };

    var instance: vk.Instance = undefined;
    const create_result = loader.vkCreateInstance.?(&instance_create_info, null, &instance);

    if (create_result != .success) {
        std.debug.print("Failed to create instance: {}\n", .{create_result});
        return error.InstanceCreationFailed;
    }
    std.debug.print("✓ Vulkan instance created successfully\n\n", .{});

    // Load instance functions
    const instance_dispatch = try loader.createInstanceDispatch(instance);
    defer instance_dispatch.vkDestroyInstance(instance, null);

    // Enumerate physical devices
    std.debug.print("Enumerating physical devices...\n", .{});
    var device_count: u32 = 0;
    _ = instance_dispatch.vkEnumeratePhysicalDevices(instance, &device_count, null);

    if (device_count == 0) {
        std.debug.print("No Vulkan-capable devices found!\n", .{});
        return;
    }

    std.debug.print("Found {} physical device(s)\n\n", .{device_count});

    // Allocate array for physical devices
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const physical_devices = try allocator.alloc(vk.PhysicalDevice, device_count);
    defer allocator.free(physical_devices);

    _ = instance_dispatch.vkEnumeratePhysicalDevices(instance, &device_count, physical_devices.ptr);

    // Print information about each device
    for (physical_devices, 0..) |physical_device, i| {
        var properties: vk.core_1_0.PhysicalDeviceProperties = undefined;
        instance_dispatch.vkGetPhysicalDeviceProperties(physical_device, &properties);

        const device_name = std.mem.sliceTo(&properties.device_name, 0);
        const device_type_str = switch (properties.device_type) {
            .discrete_gpu => "Discrete GPU",
            .integrated_gpu => "Integrated GPU",
            .virtual_gpu => "Virtual GPU",
            .cpu => "CPU",
            .other => "Other",
            _ => "Unknown",
        };

        std.debug.print("Device {}: {s}\n", .{ i, device_name });
        std.debug.print("  Type: {s}\n", .{device_type_str});
        std.debug.print("  API Version: {}.{}.{}\n", .{
            vk.constants.versionMajor(properties.api_version),
            vk.constants.versionMinor(properties.api_version),
            vk.constants.versionPatch(properties.api_version),
        });
        std.debug.print("  Driver Version: {}\n", .{properties.driver_version});
        std.debug.print("  Vendor ID: 0x{X:0>4}\n", .{properties.vendor_id});
        std.debug.print("  Device ID: 0x{X:0>4}\n\n", .{properties.device_id});

        // Query queue families
        var queue_family_count: u32 = 0;
        instance_dispatch.vkGetPhysicalDeviceQueueFamilyProperties(physical_device, &queue_family_count, null);

        const queue_families = try allocator.alloc(vk.core_1_0.QueueFamilyProperties, queue_family_count);
        defer allocator.free(queue_families);

        instance_dispatch.vkGetPhysicalDeviceQueueFamilyProperties(physical_device, &queue_family_count, queue_families.ptr);

        std.debug.print("  Queue Families: {}\n", .{queue_family_count});
        for (queue_families, 0..) |queue_family, j| {
            std.debug.print("    Family {}: {} queues, flags: ", .{ j, queue_family.queue_count });
            if (queue_family.queue_flags.graphics) std.debug.print("GRAPHICS ", .{});
            if (queue_family.queue_flags.compute) std.debug.print("COMPUTE ", .{});
            if (queue_family.queue_flags.transfer) std.debug.print("TRANSFER ", .{});
            if (queue_family.queue_flags.sparse_binding) std.debug.print("SPARSE_BINDING ", .{});
            std.debug.print("\n", .{});
        }
        std.debug.print("\n", .{});

        // Vulkan 1.1+ Check
        if (instance_dispatch.vkGetPhysicalDeviceProperties2) |get_props2| {
            std.debug.print("  [Vulkan 1.1] vkGetPhysicalDeviceProperties2 available\n", .{});

            var props13: vk.core_1_3.PhysicalDeviceVulkan13Properties = undefined;
            // Manually zero out mostly to be safe, but we depend on s_type
            props13 = std.mem.zeroes(vk.core_1_3.PhysicalDeviceVulkan13Properties);
            props13.s_type = .physical_device_vulkan_1_3_properties;

            var props2 = vk.core_1_1.PhysicalDeviceProperties2{
                .p_next = &props13,
                .properties = undefined,
            };

            get_props2(physical_device, &props2);

            if (vk.constants.versionMajor(properties.api_version) >= 1 and vk.constants.versionMinor(properties.api_version) >= 3) {
                std.debug.print("  [Vulkan 1.3] Max Subgroup Size: {}\n", .{props13.max_subgroup_size});
            }
        }
    }

    // Test graphics pipeline structure creation
    std.debug.print("Testing graphics pipeline structures...\n", .{});
    testGraphicsPipelineStructures();

    std.debug.print("✓ Example completed successfully!\n", .{});
}

fn testGraphicsPipelineStructures() void {
    // Test rasterization state
    const raster_state = vk.core_1_0.PipelineRasterizationStateCreateInfo{
        .polygon_mode = .fill,
        .cull_mode = .{ .back = true },
        .front_face = .counter_clockwise,
        .line_width = 1.0,
    };

    // Test multisample state
    const multisample_state = vk.core_1_0.PipelineMultisampleStateCreateInfo{
        .rasterization_samples = .@"4",
        .sample_shading_enable = 0,
        .min_sample_shading = 0.0,
        .alpha_to_coverage_enable = 0,
        .alpha_to_one_enable = 0,
    };

    // Test color blend attachment state
    const color_blend_attachment = vk.core_1_0.PipelineColorBlendAttachmentState{
        .blend_enable = 0,
        .src_color_blend_factor = .one,
        .dst_color_blend_factor = .zero,
        .color_blend_op = .add,
        .src_alpha_blend_factor = .one,
        .dst_alpha_blend_factor = .zero,
        .alpha_blend_op = .add,
        .color_write_mask = .{ .r = true, .g = true, .b = true, .a = true },
    };

    // Test color blend state
    const blend_constants = [_]f32{ 0.0, 0.0, 0.0, 1.0 };
    const color_blend_attachments = [_]vk.core_1_0.PipelineColorBlendAttachmentState{color_blend_attachment};
    const color_blend_state = vk.core_1_0.PipelineColorBlendStateCreateInfo{
        .logic_op_enable = 0,
        .logic_op = .copy,
        .attachment_count = 1,
        .p_attachments = &color_blend_attachments,
        .blend_constants = blend_constants,
    };

    // Test graphics pipeline create info
    const pipeline_create_info = vk.core_1_0.GraphicsPipelineCreateInfo{
        .flags = 0,
        .stage_count = 0,
        .p_stages = null,
        .p_vertex_input_state = null,
        .p_input_assembly_state = null,
        .p_tessellation_state = null,
        .p_viewport_state = null,
        .p_rasterization_state = &raster_state,
        .p_multisample_state = &multisample_state,
        .p_depth_stencil_state = null,
        .p_color_blend_state = &color_blend_state,
        .p_dynamic_state = null,
        .layout = 0, // Dummy handle for test
        .render_pass = 0, // Dummy handle for test
        .subpass = 0,
        .base_pipeline_handle = 0, // Dummy handle for test
        .base_pipeline_index = -1,
    };

    _ = pipeline_create_info; // Suppress unused variable warning
    std.debug.print("  ✓ Graphics pipeline structures created successfully\n", .{});
}
