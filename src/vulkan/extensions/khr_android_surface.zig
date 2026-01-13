//! VK_KHR_android_surface extension

const types = @import("../types.zig");

pub const KHR_ANDROID_SURFACE_EXTENSION_NAME = "VK_KHR_android_surface";

// Android Native Window handle
pub const ANativeWindow = opaque {};

pub const AndroidSurfaceCreateInfoKHR = extern struct {
    s_type: types.StructureType = .android_surface_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    window: *ANativeWindow,
};
