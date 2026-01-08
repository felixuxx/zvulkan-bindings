//! VK_KHR_wayland_surface extension

const types = @import("../types.zig");

pub const KHR_WAYLAND_SURFACE_EXTENSION_NAME = "VK_KHR_wayland_surface";

// Opaque types for Wayland handles to avoid dependencies
pub const wl_display = opaque {};
pub const wl_surface = opaque {};

pub const WaylandSurfaceCreateInfoKHR = extern struct {
    s_type: types.StructureType = .wayland_surface_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    display: *wl_display,
    surface: *wl_surface,
};
