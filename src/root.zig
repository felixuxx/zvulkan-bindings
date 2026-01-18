//! zvulkan-bindings - Comprehensive Vulkan bindings for Zig
//!
//! This library provides complete Vulkan API access with zero dependencies.
//! It uses dynamic loading for platform independence and organizes the API
//! into modular components.
//!
//! Usage:
//!   const vk = @import("zvulkan_bindings");
//!   var loader = try vk.Loader.init();
//!   defer loader.deinit();

const std = @import("std");

// Main Vulkan module
pub const vk = @import("vulkan/vk.zig");

// Re-export commonly used modules
pub const types = vk.types;
pub const constants = vk.constants;
pub const core_1_0 = vk.core_1_0;
pub const core_1_1 = vk.core_1_1;
pub const core_1_2 = vk.core_1_2;
pub const core_1_3 = vk.core_1_3;
pub const extensions = vk.extensions;

// Re-export commonly used modules (Legacy/Direct Access)
pub const khr_surface = vk.khr_surface;
pub const khr_swapchain = vk.khr_swapchain;
pub const khr_wayland_surface = vk.khr_wayland_surface;
pub const khr_xcb_surface = vk.khr_xcb_surface;
pub const khr_xlib_surface = vk.khr_xlib_surface;
pub const khr_win32_surface = vk.khr_win32_surface;
pub const khr_dynamic_rendering = vk.khr_dynamic_rendering;
pub const khr_synchronization2 = vk.khr_synchronization2;
pub const ext_mesh_shader = vk.ext_mesh_shader;
pub const ext_validation_features = vk.ext_validation_features;
pub const amd_memory_overallocation = vk.amd_memory_overallocation;
pub const intel_performance_query = vk.intel_performance_query;

// Re-export the loader
pub const Loader = vk.Loader;
pub const InstanceDispatch = vk.InstanceDispatch;
pub const DeviceDispatch = vk.DeviceDispatch;

// Re-export commonly used types
pub const Instance = vk.Instance;
pub const PhysicalDevice = vk.PhysicalDevice;
pub const Device = vk.Device;
pub const Queue = vk.Queue;
pub const CommandBuffer = vk.CommandBuffer;
pub const Result = vk.Result;

test "loader initialization" {
    // This test will only pass if Vulkan is installed on the system
    var loader = vk.Loader.init() catch |err| {
        std.debug.print("Vulkan not available: {}\n", .{err});
        return error.SkipZigTest;
    };
    defer loader.deinit();

    try std.testing.expect(loader.vkCreateInstance != null);
}
