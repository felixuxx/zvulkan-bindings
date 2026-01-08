//! VK_KHR_xlib_surface extension

const types = @import("../types.zig");

pub const KHR_XLIB_SURFACE_EXTENSION_NAME = "VK_KHR_xlib_surface";

// Opaque types for Xlib handles
pub const Display = opaque {};
pub const Window = c_ulong;

pub const XlibSurfaceCreateInfoKHR = extern struct {
    s_type: types.StructureType = .xlib_surface_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    dpy: *Display,
    window: Window,
};
