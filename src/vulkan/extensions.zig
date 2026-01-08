//! Vulkan Extensions
//! Aggregates all implemented extension modules

pub const khr_surface = @import("extensions/khr_surface.zig");
pub const khr_swapchain = @import("extensions/khr_swapchain.zig");
pub const khr_wayland_surface = @import("extensions/khr_wayland_surface.zig");
pub const khr_xcb_surface = @import("extensions/khr_xcb_surface.zig");
pub const khr_xlib_surface = @import("extensions/khr_xlib_surface.zig");
pub const khr_win32_surface = @import("extensions/khr_win32_surface.zig");
