//! VK_KHR_fragment_shading_rate extension
//! Variable rate shading for performance optimization

const constants = @import("../constants.zig");
const core_1_2 = @import("../core_1_2.zig");
const types = @import("../types.zig");

pub const KHR_FRAGMENT_SHADING_RATE_EXTENSION_NAME = "VK_KHR_fragment_shading_rate";

// ============================================================================
// Enums
// ============================================================================

pub const FragmentShadingRateNV = enum(i32) {
    @"1_invocation_per_pixel_nv" = 0,
    @"1_invocation_per_1x2_pixels_nv" = 1,
    @"1_invocation_per_2x1_pixels_nv" = 4,
    @"1_invocation_per_2x2_pixels_nv" = 5,
    @"1_invocation_per_2x4_pixels_nv" = 6,
    @"1_invocation_per_4x2_pixels_nv" = 9,
    @"1_invocation_per_4x4_pixels_nv" = 10,
    @"2_invocations_per_pixel_nv" = 11,
    @"4_invocations_per_pixel_nv" = 12,
    @"8_invocations_per_pixel_nv" = 13,
    @"16_invocations_per_pixel_nv" = 14,
    no_invocations_nv = 15,
    _,
};

pub const FragmentShadingRateTypeNV = enum(i32) {
    fragment_size_nv = 0,
    enum_nv = 1,
    _,
};

pub const FragmentShadingRateCombinerOpKHR = enum(i32) {
    keep_khr = 0,
    replace_khr = 1,
    min_khr = 2,
    max_khr = 3,
    mul_khr = 4,
    _,
};

pub const FragmentShadingRateTypeKHR = FragmentShadingRateTypeNV;

// ============================================================================
// Structures
// ============================================================================

pub const PhysicalDeviceFragmentShadingRateFeaturesKHR = extern struct {
    s_type: types.StructureType = .physical_device_fragment_shading_rate_features_khr,
    p_next: ?*anyopaque = null,
    pipeline_fragment_shading_rate: types.Bool32 = 0,
    primitive_fragment_shading_rate: types.Bool32 = 0,
    attachment_fragment_shading_rate: types.Bool32 = 0,
};

pub const PhysicalDeviceFragmentShadingRatePropertiesKHR = extern struct {
    s_type: types.StructureType = .physical_device_fragment_shading_rate_properties_khr,
    p_next: ?*anyopaque = null,
    min_fragment_shading_rate_attachment_texel_size: types.Extent2D,
    max_fragment_shading_rate_attachment_texel_size: types.Extent2D,
    max_fragment_shading_rate_attachment_texel_size_aspect_ratio: u32,
    primitive_fragment_shading_rate_with_multiple_viewports: types.Bool32,
    layered_shading_rate_attachments: types.Bool32,
    fragment_shading_rate_non_trivial_combiner_ops: types.Bool32,
    max_fragment_size: types.Extent2D,
    max_fragment_size_aspect_ratio: u32,
    max_fragment_shading_rate_coverage_samples: u32,
    max_fragment_shading_rate_rasterization_samples: types.SampleCountFlags,
    fragment_shading_rate_with_shader_depth_stencil_writes: types.Bool32,
    fragment_shading_rate_with_sample_mask: types.Bool32,
    fragment_shading_rate_with_shader_sample_mask: types.Bool32,
    fragment_shading_rate_with_conservative_rasterization: types.Bool32,
    fragment_shading_rate_with_fragment_shader_interlock: types.Bool32,
    fragment_shading_rate_with_custom_sample_locations: types.Bool32,
    fragment_shading_rate_strict_multiply_combiner: types.Bool32,
};

pub const PipelineFragmentShadingRateStateCreateInfoKHR = extern struct {
    s_type: types.StructureType = .pipeline_fragment_shading_rate_state_create_info_khr,
    p_next: ?*const anyopaque = null,
    fragment_size: types.Extent2D,
    combiner_ops: [2]FragmentShadingRateCombinerOpKHR,
};

pub const FragmentShadingRateAttachmentInfoKHR = extern struct {
    s_type: types.StructureType = .fragment_shading_rate_attachment_info_khr,
    p_next: ?*const anyopaque = null,
    p_fragment_shading_rate_attachment: ?*const core_1_2.AttachmentReference2 = null,
    shading_rate_attachment_texel_size: types.Extent2D,
};

pub const PhysicalDeviceFragmentShadingRateKHR = extern struct {
    s_type: types.StructureType = .physical_device_fragment_shading_rate_khr,
    p_next: ?*anyopaque = null,
    sample_counts: types.SampleCountFlags,
    fragment_size: types.Extent2D,
};

pub const RenderingFragmentShadingRateAttachmentInfoKHR = extern struct {
    s_type: types.StructureType = .rendering_fragment_shading_rate_attachment_info_khr,
    p_next: ?*const anyopaque = null,
    image_view: types.ImageView = .null_handle,
    image_layout: types.ImageLayout,
    shading_rate_attachment_texel_size: types.Extent2D,
};
