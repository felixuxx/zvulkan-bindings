//! VK_KHR_xcb_surface extension

const types = @import("../types.zig");

pub const KHR_XCB_SURFACE_EXTENSION_NAME = "VK_KHR_xcb_surface";

// Opaque types for XCB handles
pub const xcb_connection_t = opaque {};
pub const xcb_window_t = u32;

pub const XcbSurfaceCreateInfoKHR = extern struct {
    s_type: types.StructureType = .xcb_surface_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    connection: *xcb_connection_t,
    window: xcb_window_t,
};
