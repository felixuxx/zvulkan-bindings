//! Vulkan 1.4 Core Structures and Functions

const types = @import("types.zig");
const core_1_0 = @import("core_1_0.zig");
const constants = @import("constants.zig");

// ============================================================================
// Vulkan 1.4 Features and Properties
// ============================================================================

pub const PhysicalDeviceVulkan14Features = extern struct {
    s_type: types.StructureType = .physical_device_vulkan_1_4_features,
    p_next: ?*anyopaque = null,
    global_priority_query: types.Bool32,
    shader_subgroup_rotate: types.Bool32,
    shader_subgroup_rotate_clustered: types.Bool32,
    shader_float_controls2: types.Bool32,
    shader_expect_assume: types.Bool32,
    rectangular_lines: types.Bool32,
    bresenham_lines: types.Bool32,
    smooth_lines: types.Bool32,
    stippled_rectangular_lines: types.Bool32,
    stippled_bresenham_lines: types.Bool32,
    stippled_smooth_lines: types.Bool32,
    vertex_attribute_instance_rate_divisor: types.Bool32,
    vertex_attribute_instance_rate_zero_divisor: types.Bool32,
    index_type_uint8: types.Bool32,
    dynamic_rendering_local_read: types.Bool32,
    maintenance5: types.Bool32,
    maintenance6: types.Bool32,
    pipeline_protected_access: types.Bool32,
    pipeline_robustness: types.Bool32,
    host_image_copy: types.Bool32,
    push_descriptor: types.Bool32,
};

pub const PhysicalDeviceVulkan14Properties = extern struct {
    s_type: types.StructureType = .physical_device_vulkan_1_4_properties,
    p_next: ?*anyopaque = null,
    line_sub_pixel_precision_bits: u32,
    max_vertex_attrib_divisor: u32,
    supports_non_zero_first_instance: types.Bool32,
    max_push_descriptors: u32,
    dynamic_rendering_local_read_depth_stencil_attachments: types.Bool32,
    dynamic_rendering_local_read_multisampled_attachments: types.Bool32,
    early_fragment_multisample_coverage_after_sample_counting: types.Bool32,
    early_fragment_sample_mask_test_before_sample_counting: types.Bool32,
    depth_stencil_swizzle_one_support: types.Bool32,
    polygon_mode_point_size: types.Bool32,
    non_strict_single_pixel_wide_lines_use_parallelogram: types.Bool32,
    non_strict_wide_lines_use_parallelogram: types.Bool32,
    block_texel_view_compatible_multiple_layers: types.Bool32,
    max_combined_image_sampler_descriptor_count: u32,
    fragment_shading_rate_clamp_combiner_inputs: types.Bool32,
    default_robustness_storage_buffers: types.Bool32,
    default_robustness_uniform_buffers: types.Bool32,
    default_robustness_vertex_inputs: types.Bool32,
    default_robustness_images: types.Bool32,
    copy_src_layout_count: u32,
    p_copy_src_layouts: ?[*]const types.ImageLayout,
    copy_dst_layout_count: u32,
    p_copy_dst_layouts: ?[*]const types.ImageLayout,
};

// Add promoted extension structs here, e.g., from maintenance5
pub const DeviceImageSubresourceInfoKHR = extern struct {
    s_type: types.StructureType = .device_image_subresource_info,
    p_next: ?*const anyopaque = null,
    p_create_info: ?*const core_1_0.ImageCreateInfo,
    p_subresource: ?*const ImageSubresource2KHR,
};

pub const ImageSubresource2KHR = extern struct {
    s_type: types.StructureType = .image_subresource_2,
    p_next: ?*anyopaque = null,
    image_subresource: types.ImageSubresource,
};

// ============================================================================
// VK_KHR_maintenance5 (promoted to 1.4)
// ============================================================================

pub const RenderingAreaInfoKHR = extern struct {
    s_type: types.StructureType = .rendering_area_info_khr,
    p_next: ?*const anyopaque = null,
    view_mask: u32,
    color_attachment_count: u32,
    p_color_attachment_formats: ?[*]const types.Format,
    depth_attachment_format: types.Format,
    stencil_attachment_format: types.Format,
};

pub const SubresourceLayout2KHR = extern struct {
    s_type: types.StructureType = .subresource_layout_2_khr,
    p_next: ?*anyopaque = null,
    subresource_layout: types.SubresourceLayout,
};

// ============================================================================
// VK_KHR_maintenance6 (promoted to 1.4)
// ============================================================================

pub const BindMemoryStatusKHR = extern struct {
    s_type: types.StructureType = .bind_memory_status_khr,
    p_next: ?*anyopaque = null,
    p_result: ?*types.Result,
};

// ============================================================================
// VK_EXT_host_image_copy (promoted to 1.4)
// ============================================================================

// Add more structs as needed for other extensions
