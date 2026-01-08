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
        .api_version = vk.constants.API_VERSION_1_0,
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
    }

    std.debug.print("✓ Example completed successfully!\n", .{});
}
