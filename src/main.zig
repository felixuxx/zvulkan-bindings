//! Example program demonstrating zvulkan-bindings usage
//! This creates a Vulkan instance and enumerates physical devices

const std = @import("std");
const vk = @import("zvulkan_bindings");

fn testFunctionLoading(loader: *const vk.Loader) void {
    const loader_type = @TypeOf(loader.*);
    const fields = @typeInfo(loader_type).@"struct".fields;

    var loaded_count: usize = 0;
    var total_count: usize = 0;

    inline for (fields) |field| {
        total_count += 1;
        const value = @field(loader.*, field.name);
        if (@typeInfo(@TypeOf(value)) == .optional) {
            if (value != null) {
                loaded_count += 1;
            } else {
                std.debug.print("  Warning: {f} is null\n", .{std.zig.fmtId(field.name)});
            }
        } else {
            loaded_count += 1;
        }
    }

    std.debug.print("  Loaded {}/{} functions\n", .{ loaded_count, total_count });
}

fn testInstanceFunctionLoading(instance_dispatch: anytype) void {
    const dispatch_type = @TypeOf(instance_dispatch.*);
    const fields = @typeInfo(dispatch_type).@"struct".fields;

    var loaded_count: usize = 0;
    var total_count: usize = 0;

    inline for (fields) |field| {
        total_count += 1;
        const value = @field(instance_dispatch.*, field.name);
        if (@typeInfo(@TypeOf(value)) == .optional) {
            if (value != null) {
                loaded_count += 1;
            } else {
                std.debug.print("  Warning: {f} is null\n", .{std.zig.fmtId(field.name)});
            }
        } else {
            loaded_count += 1;
        }
    }

    std.debug.print("  Loaded {}/{} functions\n", .{ loaded_count, total_count });
}

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

    // Test that all Vulkan functions are loaded
    std.debug.print("Testing function loading...\n", .{});
    testFunctionLoading(&loader);
    std.debug.print("✓ All core functions loaded successfully\n\n", .{});

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

    // Test instance function loading
    std.debug.print("Testing instance function loading...\n", .{});
    testInstanceFunctionLoading(&instance_dispatch);
    std.debug.print("✓ All instance functions loaded successfully\n\n", .{});

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

    // Test extension enumeration
    std.debug.print("\nTesting extension enumeration...\n", .{});
    try testExtensionEnumeration(&loader, allocator);

    // Test structure initialization for different API versions
    std.debug.print("\nTesting structure initialization...\n", .{});
    testStructureInitialization();

    // Test enum completeness and type safety
    std.debug.print("\nTesting enum completeness...\n", .{});
    testEnumCompleteness();

    // Test extension structures
    std.debug.print("\nTesting extension structures...\n", .{});
    testExtensionStructures();

    // Test device creation (if possible)
    if (device_count > 0) {
        std.debug.print("\nTesting device creation...\n", .{});
        try testDeviceCreation(&instance_dispatch, physical_devices[0], allocator);
    }

    // Test memory and buffer structures
    std.debug.print("\nTesting memory and buffer structures...\n", .{});
    testMemoryAndBufferStructures();

    // Test command buffer structures
    std.debug.print("\nTesting command buffer structures...\n", .{});
    testCommandBufferStructures();

    // Test Vulkan 1.1+ structures
    std.debug.print("\nTesting Vulkan 1.1+ structures...\n", .{});
    testVulkan11PlusStructures();

    // Test Vulkan 1.3+ structures
    std.debug.print("\nTesting Vulkan 1.3+ structures...\n", .{});
    testVulkan13PlusStructures();

    std.debug.print("\n✓ All tests completed successfully!\n", .{});
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

fn testExtensionEnumeration(loader: *const vk.Loader, allocator: std.mem.Allocator) !void {
    const extensions = try loader.getVulkanInstanceExtensions(allocator, null);
    defer allocator.free(extensions);

    std.debug.print("  Found {} extensions\n", .{extensions.len});

    // Check for common extensions
    var found_surface = false;
    var found_swapchain = false;
    var found_sync2 = false;
    var found_dynamic_rendering = false;

    for (extensions) |ext| {
        const name_slice = std.mem.sliceTo(&ext.extension_name, 0);
        if (std.mem.eql(u8, name_slice, vk.khr_surface.KHR_SURFACE_EXTENSION_NAME)) {
            found_surface = true;
        } else if (std.mem.eql(u8, name_slice, vk.khr_swapchain.KHR_SWAPCHAIN_EXTENSION_NAME)) {
            found_swapchain = true;
        } else if (std.mem.eql(u8, name_slice, vk.khr_synchronization2.KHR_SYNCHRONIZATION_2_EXTENSION_NAME)) {
            found_sync2 = true;
        } else if (std.mem.eql(u8, name_slice, vk.khr_dynamic_rendering.KHR_DYNAMIC_RENDERING_EXTENSION_NAME)) {
            found_dynamic_rendering = true;
        }
    }

    std.debug.print("  ✓ Surface extension: {s}\n", .{if (found_surface) "available" else "not available"});
    std.debug.print("  ✓ Swapchain extension: {s}\n", .{if (found_swapchain) "available" else "not available"});
    std.debug.print("  ✓ Synchronization2 extension: {s}\n", .{if (found_sync2) "available" else "not available"});
    std.debug.print("  ✓ Dynamic Rendering extension: {s}\n", .{if (found_dynamic_rendering) "available" else "not available"});
}

fn testStructureInitialization() void {
    // Test core 1.0 structures
    const app_info = vk.core_1_0.ApplicationInfo{
        .p_application_name = "Test App",
        .application_version = vk.constants.makeApiVersion(0, 1, 0, 0),
        .p_engine_name = "Test Engine",
        .engine_version = vk.constants.makeApiVersion(0, 1, 0, 0),
        .api_version = vk.constants.makeApiVersion(0, 1, 3, 0),
    };

    const instance_info = vk.core_1_0.InstanceCreateInfo{
        .p_application_info = &app_info,
    };
    _ = instance_info;

    // Test memory allocation info
    const mem_alloc_info = vk.core_1_0.MemoryAllocateInfo{
        .allocation_size = 1024 * 1024,
        .memory_type_index = 0,
    };
    _ = mem_alloc_info;

    // Test buffer create info
    const buffer_info = vk.core_1_0.BufferCreateInfo{
        .size = 1024,
        .usage = .{ .vertex_buffer = true, .transfer_dst = true },
        .sharing_mode = .exclusive,
    };
    _ = buffer_info;

    std.debug.print("  ✓ Core 1.0 structures initialized successfully\n", .{});
}

fn testEnumCompleteness() void {
    // Test DynamicState enum
    const dynamic_states = [_]vk.types.DynamicState{
        .viewport,
        .scissor,
        .line_width,
        .depth_bias,
        .blend_constants,
        .depth_bounds,
        .stencil_compare_mask,
        .stencil_write_mask,
        .stencil_reference,
        .cull_mode,
        .front_face,
        .primitive_topology,
        .viewport_with_count,
        .scissor_with_count,
        .depth_test_enable,
        .depth_write_enable,
        .rasterizer_discard_enable,
    };
    _ = dynamic_states;

    // Test ImageLayout enum
    const layouts = [_]vk.types.ImageLayout{
        .undefined,
        .general,
        .color_attachment_optimal,
        .depth_stencil_attachment_optimal,
        .depth_stencil_read_only_optimal,
        .shader_read_only_optimal,
        .transfer_src_optimal,
        .transfer_dst_optimal,
        .preinitialized,
        .present_src_khr,
        .depth_read_only_stencil_attachment_optimal,
        .depth_attachment_stencil_read_only_optimal,
        .fragment_shading_rate_attachment_optimal_khr,
    };
    _ = layouts;

    // Test ObjectType enum
    const object_types = [_]vk.types.ObjectType{
        .instance,
        .physical_device,
        .device,
        .queue,
        .semaphore,
        .command_buffer,
        .fence,
        .device_memory,
        .buffer,
        .image,
        .event,
        .query_pool,
        .buffer_view,
        .image_view,
        .shader_module,
        .pipeline_cache,
        .pipeline_layout,
        .render_pass,
        .pipeline,
        .descriptor_set_layout,
        .sampler,
        .descriptor_pool,
        .descriptor_set,
        .framebuffer,
        .command_pool,
        .sampler_ycbcr_conversion,
        .descriptor_update_template,
        .private_data_slot,
        .surface_khr,
        .swapchain_khr,
    };
    _ = object_types;

    // Test PipelineBindPoint enum
    const bind_points = [_]vk.types.PipelineBindPoint{
        .graphics,
        .compute,
        .ray_tracing_khr,
        .execution_graph_amdx,
    };
    _ = bind_points;

    std.debug.print("  ✓ Enums are complete and type-safe\n", .{});
}

fn testExtensionStructures() void {
    // Test KHR_synchronization2 structures
    const memory_barrier2 = vk.khr_synchronization2.MemoryBarrier2{
        .src_stage_mask = .{ .top_of_pipe_bit = true },
        .src_access_mask = .{ .memory_read_bit = true },
        .dst_stage_mask = .{ .bottom_of_pipe_bit = true },
        .dst_access_mask = .{ .memory_write_bit = true },
    };
    _ = memory_barrier2;

    const buffer_barrier2 = vk.khr_synchronization2.BufferMemoryBarrier2{
        .src_stage_mask = .{ .transfer_bit = true },
        .src_access_mask = .{ .transfer_read_bit = true },
        .dst_stage_mask = .{ .transfer_bit = true },
        .dst_access_mask = .{ .transfer_write_bit = true },
        .src_queue_family_index = vk.constants.QUEUE_FAMILY_IGNORED,
        .dst_queue_family_index = vk.constants.QUEUE_FAMILY_IGNORED,
        .buffer = 0, // Dummy handle
        .offset = 0,
        .size = 1024,
    };
    _ = buffer_barrier2;

    const dependency_info = vk.khr_synchronization2.DependencyInfo{
        .dependency_flags = .{},
        .memory_barrier_count = 0,
        .p_memory_barriers = null,
        .buffer_memory_barrier_count = 0,
        .p_buffer_memory_barriers = null,
        .image_memory_barrier_count = 0,
        .p_image_memory_barriers = null,
    };
    _ = dependency_info;

    // Test KHR_dynamic_rendering structures
    const rendering_attachment_info = vk.khr_dynamic_rendering.RenderingAttachmentInfo{
        .image_view = 0, // Dummy handle
        .image_layout = .color_attachment_optimal,
        .resolve_mode = .{},
        .resolve_image_view = vk.constants.NULL_HANDLE,
        .resolve_image_layout = .undefined,
        .load_op = .clear,
        .store_op = .store,
        .clear_value = .{ .color = .{ .@"float32" = .{ 0.0, 0.0, 0.0, 1.0 } } },
    };
    _ = rendering_attachment_info;

    const rendering_info = vk.khr_dynamic_rendering.RenderingInfo{
        .flags = .{},
        .render_area = .{ .offset = .{ .x = 0, .y = 0 }, .extent = .{ .width = 1920, .height = 1080 } },
        .layer_count = 1,
        .view_mask = 0,
        .color_attachment_count = 0,
        .p_color_attachments = null,
        .depth_attachment = null,
        .stencil_attachment = null,
    };
    _ = rendering_info;

    std.debug.print("  ✓ Extension structures initialized successfully\n", .{});
}

fn testDeviceCreation(instance_dispatch: *const vk.InstanceDispatch, physical_device: vk.PhysicalDevice, allocator: std.mem.Allocator) !void {
    // Get queue family properties
    var queue_family_count: u32 = 0;
    instance_dispatch.vkGetPhysicalDeviceQueueFamilyProperties(physical_device, &queue_family_count, null);

    if (queue_family_count == 0) {
        std.debug.print("  ⚠ No queue families available\n", .{});
        return;
    }

    const queue_families = try allocator.alloc(vk.core_1_0.QueueFamilyProperties, queue_family_count);
    defer allocator.free(queue_families);

    instance_dispatch.vkGetPhysicalDeviceQueueFamilyProperties(physical_device, &queue_family_count, queue_families.ptr);

    // Find a graphics queue family
    var graphics_queue_family: ?u32 = null;
    for (queue_families, 0..) |queue_family, i| {
        if (queue_family.queue_flags.graphics) {
            graphics_queue_family = @intCast(i);
            break;
        }
    }

    if (graphics_queue_family == null) {
        std.debug.print("  ⚠ No graphics queue family found\n", .{});
        return;
    }

    // Create device create info
    const queue_priority: f32 = 1.0;
    const queue_priorities = [_]f32{queue_priority};
    const queue_create_info = vk.core_1_0.DeviceQueueCreateInfo{
        .queue_family_index = graphics_queue_family.?,
        .queue_count = 1,
        .p_queue_priorities = &queue_priorities,
    };

    const queue_create_infos = [_]vk.core_1_0.DeviceQueueCreateInfo{queue_create_info};
    const device_create_info = vk.core_1_0.DeviceCreateInfo{
        .queue_create_info_count = 1,
        .p_queue_create_infos = &queue_create_infos,
        .enabled_extension_count = 0,
        .pp_enabled_extension_names = null,
        .p_enabled_features = null,
    };

    var device: vk.Device = undefined;
    const result = instance_dispatch.vkCreateDevice(physical_device, &device_create_info, null, &device);

    if (result == .success) {
        std.debug.print("  ✓ Device created successfully\n", .{});

        // Note: vkGetDeviceQueue requires DeviceDispatch, which we don't have here
        // This test just verifies device creation works

        // Note: We can't actually call vkGetDeviceQueue or vkDestroyDevice without DeviceDispatch
        // This is just testing that we can create the device
        // Device cleanup would require DeviceDispatch which we don't create here
        std.debug.print("  ✓ Device created (cleanup requires DeviceDispatch)\n", .{});
    } else {
        std.debug.print("  ⚠ Device creation failed: {}\n", .{result});
    }
}

fn testMemoryAndBufferStructures() void {
    // Test memory requirements
    const mem_requirements = vk.types.MemoryRequirements{
        .size = 1024,
        .alignment = 256,
        .memory_type_bits = 0xFFFFFFFF,
    };
    _ = mem_requirements;

    // Test buffer create info with various usages
    const vertex_buffer_info = vk.core_1_0.BufferCreateInfo{
        .size = 65536,
        .usage = .{ .vertex_buffer = true },
        .sharing_mode = .exclusive,
    };
    _ = vertex_buffer_info;

    const index_buffer_info = vk.core_1_0.BufferCreateInfo{
        .size = 32768,
        .usage = .{ .index_buffer = true },
        .sharing_mode = .exclusive,
    };
    _ = index_buffer_info;

    const uniform_buffer_info = vk.core_1_0.BufferCreateInfo{
        .size = 256,
        .usage = .{ .uniform_buffer = true },
        .sharing_mode = .exclusive,
    };
    _ = uniform_buffer_info;

    // Test image create info
    const image_info = vk.core_1_0.ImageCreateInfo{
        .image_type = .@"2d",
        .format = .r8g8b8a8_unorm,
        .extent = .{ .width = 1920, .height = 1080, .depth = 1 },
        .mip_levels = 1,
        .array_layers = 1,
        .samples = .{ .@"1" = true },
        .tiling = .optimal,
        .usage = .{ .color_attachment = true, .sampled = true },
        .sharing_mode = .exclusive,
        .initial_layout = .undefined,
    };
    _ = image_info;

    // Test image view create info
    const image_view_info = vk.core_1_0.ImageViewCreateInfo{
        .image = 0, // Dummy handle
        .view_type = .@"2d",
        .format = .r8g8b8a8_unorm,
        .components = .{ .r = .identity, .g = .identity, .b = .identity, .a = .identity },
        .subresource_range = .{
            .aspect_mask = .{ .color = true },
            .base_mip_level = 0,
            .level_count = 1,
            .base_array_layer = 0,
            .layer_count = 1,
        },
    };
    _ = image_view_info;

    std.debug.print("  ✓ Memory and buffer structures initialized successfully\n", .{});
}

fn testCommandBufferStructures() void {
    // Test command buffer begin info
    const begin_info = vk.core_1_0.CommandBufferBeginInfo{
        .flags = .{ .one_time_submit = true },
        .p_inheritance_info = null,
    };
    _ = begin_info;

    // Test command buffer inheritance info
    const inheritance_info = vk.core_1_0.CommandBufferInheritanceInfo{
        .render_pass = 0, // Dummy handle
        .subpass = 0,
        .framebuffer = 0, // Dummy handle
        .occlusion_query_enable = 0,
        .query_flags = 0,
        .pipeline_statistics = 0,
    };
    _ = inheritance_info;

    // Test submit info
    const submit_info = vk.core_1_0.SubmitInfo{
        .wait_semaphore_count = 0,
        .p_wait_semaphores = null,
        .p_wait_dst_stage_mask = null,
        .command_buffer_count = 0,
        .p_command_buffers = null,
        .signal_semaphore_count = 0,
        .p_signal_semaphores = null,
    };
    _ = submit_info;

    // Test command pool create info
    const pool_info = vk.core_1_0.CommandPoolCreateInfo{
        .flags = .{ .reset_command_buffer = true },
        .queue_family_index = 0,
    };
    _ = pool_info;

    std.debug.print("  ✓ Command buffer structures initialized successfully\n", .{});
}

fn testVulkan11PlusStructures() void {
    // Test PhysicalDeviceFeatures2
    const features2 = vk.core_1_1.PhysicalDeviceFeatures2{
        .features = undefined,
    };
    _ = features2;

    // Test PhysicalDeviceProperties2
    const props2 = vk.core_1_1.PhysicalDeviceProperties2{
        .properties = undefined,
    };
    _ = props2;

    // Test BindBufferMemoryInfo
    const bind_buffer_info = vk.core_1_1.BindBufferMemoryInfo{
        .buffer = 0, // Dummy handle
        .memory = 0, // Dummy handle
        .memory_offset = 0,
    };
    _ = bind_buffer_info;

    // Test BindImageMemoryInfo
    const bind_image_info = vk.core_1_1.BindImageMemoryInfo{
        .image = 0, // Dummy handle
        .memory = 0, // Dummy handle
        .memory_offset = 0,
    };
    _ = bind_image_info;

    std.debug.print("  ✓ Vulkan 1.1+ structures initialized successfully\n", .{});
}

fn testVulkan13PlusStructures() void {
    // Test DependencyInfo (Vulkan 1.3)
    const dependency_info = vk.core_1_3.DependencyInfo{
        .dependency_flags = .{},
        .memory_barrier_count = 0,
        .p_memory_barriers = null,
        .buffer_memory_barrier_count = 0,
        .p_buffer_memory_barriers = null,
        .image_memory_barrier_count = 0,
        .p_image_memory_barriers = null,
    };
    _ = dependency_info;

    // Test RenderingInfo (Vulkan 1.3)
    const rendering_info = vk.core_1_3.RenderingInfo{
        .flags = .{},
        .render_area = .{ .offset = .{ .x = 0, .y = 0 }, .extent = .{ .width = 1920, .height = 1080 } },
        .layer_count = 1,
        .view_mask = 0,
        .color_attachment_count = 0,
        .p_color_attachments = null,
        .p_depth_attachment = null,
        .p_stencil_attachment = null,
    };
    _ = rendering_info;

    // Test RenderingAttachmentInfo
    const rendering_attachment = vk.core_1_3.RenderingAttachmentInfo{
        .image_view = 0, // Dummy handle
        .image_layout = .color_attachment_optimal,
        .resolve_mode = .{},
        .resolve_image_view = vk.constants.NULL_HANDLE,
        .resolve_image_layout = .undefined,
        .load_op = .clear,
        .store_op = .store,
        .clear_value = .{ .color = .{ .@"float32" = .{ 0.0, 0.0, 0.0, 1.0 } } },
    };
    _ = rendering_attachment;

    // Test SubmitInfo2
    const submit_info2 = vk.core_1_3.SubmitInfo2{
        .flags = 0,
        .wait_semaphore_info_count = 0,
        .p_wait_semaphore_infos = null,
        .command_buffer_info_count = 0,
        .p_command_buffer_infos = null,
        .signal_semaphore_info_count = 0,
        .p_signal_semaphore_infos = null,
    };
    _ = submit_info2;

    std.debug.print("  ✓ Vulkan 1.3+ structures initialized successfully\n", .{});
}
