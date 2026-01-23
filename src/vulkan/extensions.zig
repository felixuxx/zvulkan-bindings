//! Vulkan Extensions
//! Aggregates all implemented extension modules

pub const khr_surface = @import("extensions/khr_surface.zig");
pub const khr_swapchain = @import("extensions/khr_swapchain.zig");
pub const khr_wayland_surface = @import("extensions/khr_wayland_surface.zig");
pub const khr_xcb_surface = @import("extensions/khr_xcb_surface.zig");
pub const khr_xlib_surface = @import("extensions/khr_xlib_surface.zig");
pub const khr_win32_surface = @import("extensions/khr_win32_surface.zig");
pub const khr_dynamic_rendering = @import("extensions/khr_dynamic_rendering.zig");
pub const khr_synchronization2 = @import("extensions/khr_synchronization2.zig");
pub const khr_push_descriptor = @import("extensions/khr_push_descriptor.zig");
pub const khr_fragment_shading_rate = @import("extensions/khr_fragment_shading_rate.zig");
pub const ext_mesh_shader = @import("extensions/ext_mesh_shader.zig");
pub const ext_validation_features = @import("extensions/ext_validation_features.zig");
pub const amd_memory_overallocation = @import("extensions/amd_memory_overallocation.zig");
pub const intel_performance_query = @import("extensions/intel_performance_query.zig");
pub const ext_host_image_copy = @import("extensions/ext_host_image_copy.zig");
