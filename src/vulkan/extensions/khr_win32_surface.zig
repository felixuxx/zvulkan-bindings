//! VK_KHR_win32_surface extension

const types = @import("../types.zig");

pub const KHR_WIN32_SURFACE_EXTENSION_NAME = "VK_KHR_win32_surface";

// Opaque types for Win32 handles
pub const HINSTANCE = *opaque {};
pub const HWND = *opaque {};

pub const Win32SurfaceCreateInfoKHR = extern struct {
    s_type: types.StructureType = .win32_surface_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    hinstance: HINSTANCE,
    hwnd: HWND,
};
