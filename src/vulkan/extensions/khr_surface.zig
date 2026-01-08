//! VK_KHR_surface extension
//! Common surface types and function signatures

const types = @import("../types.zig");
const constants = @import("../constants.zig");

pub const KHR_SURFACE_EXTENSION_NAME = "VK_KHR_surface";

// ============================================================================
// Enums
// ============================================================================

pub const ColorSpaceKHR = enum(i32) {
    srgb_nonlinear_khr = 0,
    display_p3_nonlinear_ext = 1000104001,
    extended_srgb_linear_ext = 1000104002,
    display_p3_linear_ext = 1000104003,
    dci_p3_nonlinear_ext = 1000104004,
    bt709_linear_ext = 1000104005,
    bt709_nonlinear_ext = 1000104006,
    bt2020_linear_ext = 1000104007,
    hdr10_st2084_ext = 1000104008,
    dolbyvision_ext = 1000104009,
    hdr10_hlg_ext = 1000104010,
    adobergb_linear_ext = 1000104011,
    adobergb_nonlinear_ext = 1000104012,
    pass_through_ext = 1000104013,
    extended_srgb_nonlinear_ext = 1000104014,
    display_native_amd = 1000213000,
    _,
};

pub const PresentModeKHR = enum(i32) {
    immediate_khr = 0,
    mailbox_khr = 1,
    fifo_khr = 2,
    fifo_relaxed_khr = 3,
    shared_demand_refresh_khr = 1000111000,
    shared_continuous_refresh_khr = 1000111001,
    _,
};

pub const CompositeAlphaFlagBitsKHR = packed struct(u32) {
    opaque_khr: bool = false,
    pre_multiplied_khr: bool = false,
    post_multiplied_khr: bool = false,
    inherit_khr: bool = false,
    _padding: u28 = 0,
};

pub const SurfaceTransformFlagBitsKHR = packed struct(u32) {
    identity_khr: bool = false,
    rotate_90_khr: bool = false,
    rotate_180_khr: bool = false,
    rotate_270_khr: bool = false,
    horizontal_mirror_khr: bool = false,
    horizontal_mirror_rotate_90_khr: bool = false,
    horizontal_mirror_rotate_180_khr: bool = false,
    horizontal_mirror_rotate_270_khr: bool = false,
    inherit_khr: bool = false,
    _padding: u23 = 0,
};

// ============================================================================
// Structures
// ============================================================================

pub const SurfaceCapabilitiesKHR = extern struct {
    min_image_count: u32,
    max_image_count: u32,
    current_extent: types.Extent2D,
    min_image_extent: types.Extent2D,
    max_image_extent: types.Extent2D,
    max_image_array_layers: u32,
    supported_transforms: SurfaceTransformFlagBitsKHR,
    current_transform: SurfaceTransformFlagBitsKHR,
    supported_composite_alpha: CompositeAlphaFlagBitsKHR,
    supported_usage_flags: types.ImageUsageFlags,
};

pub const SurfaceFormatKHR = extern struct {
    format: types.Format,
    color_space: ColorSpaceKHR,
};
