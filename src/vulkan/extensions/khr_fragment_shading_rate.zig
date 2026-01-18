//! VK_KHR_fragment_shading_rate extension
//! Variable rate shading for performance optimization

const types = @import("../types.zig");
const constants = @import("../constants.zig");

pub const KHR_FRAGMENT_SHADING_RATE_EXTENSION_NAME = "VK_KHR_fragment_shading_rate";

// ============================================================================
// Enums
// ============================================================================

pub const FragmentShadingRateNV = enum(u32) {
    @"1_invocation_per_pixel" = 1,
    @"1_invocation_per_2_pixels" = 2,
    @"1_invocation_per_4_pixels" = 4,
    @"1_invocation_per_8_pixels" = 8,
    @"1_invocation_per_16_pixels" = 16,
    @"1_invocation_per_32_pixels" = 32,
    @"2_invocations_per_pixel" = 4,
    @"4_invocations_per_pixel" = 8,
    @"8_invocations_per_pixel" = 16,
    @"16_invocations_per_pixel" = 32,
};

pub const FragmentShadingRateTypeNV = enum(u32) {
    fragment_size_nv = 0,
    enum_nv = 1,
};

pub const FragmentShadingRateCombinerOpKHR = enum(u32) {
    replace_khr = 0,
    min_khr = 1,
    max_khr = 2,
    multiply_khr = 3,
};

pub const FragmentShadingRateTypeKHR = FragmentShadingRateTypeNV;

// ============================================================================
// Structures
// ============================================================================

pub const PhysicalDeviceFragmentShadingRateFeaturesKHR = extern struct {
    s_type: types.StructureType = .physical_device_fragment_shading_rate_features_khr,
    p_next: ?*const anyopaque = null,
    pipeline_fragment_shading_rate: types.Bool32 = 0,
    primitive_fragment_shading_rate: types.Bool32 = 0,
    attachment_fragment_shading_rate: types.Bool32 = 0,
};

pub const PhysicalDeviceFragmentShadingRatePropertiesKHR = extern struct {
    s_type: types.StructureType = .physical_device_fragment_shading_rate_properties_khr,
    p_next: ?*const anyopaque = null,
    min_fragment_shading_rate_attachment_sampled_images: types.SampleCountFlagBits = .@"1",
    max_fragment_shading_rate_attachment_sampled_images: types.SampleCountFlagBits = .@"1",
    max_fragment_shading_rate_with_sample_shading_rate: FragmentShadingRateNV = .@"1_invocation_per_pixel",
    max_fragment_size: types.Extent2D,
    max_fragment_size_aspect: [2]types.Extent2D,
    max_fragment_shading_rate_coverage_samples: types.SampleCountFlagBits = .@"1",
    max_fragment_shading_rate_attachment_samples: types.SampleCountFlagBits = .@"1",
    shading_rate_attachment_samples: types.SampleCountFlagBits = .@"1",
    shading_rate_coarse_samples: types.SampleCountFlagBits = .@"1",
};

pub const PipelineFragmentShadingRateStateCreateInfoKHR = extern struct {
    s_type: types.StructureType = .pipeline_fragment_shading_rate_state_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineFragmentShadingRateStateCreateFlagsKHR,
    fragment_size: types.Extent2D,
    fragment_size_count: u32 = 0,
    combiner_op: FragmentShadingRateCombinerOpKHR = .replace_khr,
};
