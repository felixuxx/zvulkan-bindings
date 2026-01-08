//! Vulkan 1.3 Core Structures and Functions

const types = @import("types.zig");
const constants = @import("constants.zig");

// ============================================================================
// Structures
// ============================================================================

pub const PhysicalDeviceVulkan13Features = extern struct {
    s_type: types.StructureType = .physical_device_vulkan_1_3_features,
    p_next: ?*anyopaque = null,
    robust_image_access: types.Bool32,
    inline_uniform_block: types.Bool32,
    descriptor_binding_inline_uniform_block_update_after_bind: types.Bool32,
    pipeline_creation_cache_control: types.Bool32,
    private_data: types.Bool32,
    shader_demote_to_helper_invocation: types.Bool32,
    shader_terminate_invocation: types.Bool32,
    subgroup_size_control: types.Bool32,
    compute_full_subgroups: types.Bool32,
    synchronization2: types.Bool32,
    texture_compression_astc_hdr: types.Bool32,
    shader_zero_initialize_workgroup_memory: types.Bool32,
    dynamic_rendering: types.Bool32,
    shader_integer_dot_product: types.Bool32,
    maintenance4: types.Bool32,
};

pub const PhysicalDeviceVulkan13Properties = extern struct {
    s_type: types.StructureType = .physical_device_vulkan_1_3_properties,
    p_next: ?*anyopaque = null,
    min_subgroup_size: u32,
    max_subgroup_size: u32,
    max_compute_workgroup_subgroups: u32,
    required_subgroup_size_stages: types.ShaderStageFlags,
    max_inline_uniform_block_size: u32,
    max_per_stage_descriptor_inline_uniform_blocks: u32,
    max_per_stage_descriptor_update_after_bind_inline_uniform_blocks: u32,
    max_descriptor_set_inline_uniform_blocks: u32,
    max_descriptor_set_update_after_bind_inline_uniform_blocks: u32,
    max_inline_uniform_total_size: u32,
    integer_dot_product_8_bit_unsigned_accelerated: types.Bool32,
    integer_dot_product_8_bit_signed_accelerated: types.Bool32,
    integer_dot_product_8_bit_mixed_signedness_accelerated: types.Bool32,
    integer_dot_product_4_x_8_bit_packed_unsigned_accelerated: types.Bool32,
    integer_dot_product_4_x_8_bit_packed_signed_accelerated: types.Bool32,
    integer_dot_product_4_x_8_bit_packed_mixed_signedness_accelerated: types.Bool32,
    integer_dot_product_16_bit_unsigned_accelerated: types.Bool32,
    integer_dot_product_16_bit_signed_accelerated: types.Bool32,
    integer_dot_product_16_bit_mixed_signedness_accelerated: types.Bool32,
    integer_dot_product_32_bit_unsigned_accelerated: types.Bool32,
    integer_dot_product_32_bit_signed_accelerated: types.Bool32,
    integer_dot_product_32_bit_mixed_signedness_accelerated: types.Bool32,
    integer_dot_product_64_bit_unsigned_accelerated: types.Bool32,
    integer_dot_product_64_bit_signed_accelerated: types.Bool32,
    integer_dot_product_64_bit_mixed_signedness_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_8_bit_unsigned_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_8_bit_signed_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_8_bit_mixed_signedness_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_4_x_8_bit_packed_unsigned_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_4_x_8_bit_packed_signed_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_4_x_8_bit_packed_mixed_signedness_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_16_bit_unsigned_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_16_bit_signed_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_16_bit_mixed_signedness_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_32_bit_unsigned_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_32_bit_signed_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_32_bit_mixed_signedness_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_64_bit_unsigned_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_64_bit_signed_accelerated: types.Bool32,
    integer_dot_product_accumulating_saturating_64_bit_mixed_signedness_accelerated: types.Bool32,
    storage_texel_buffer_offset_alignment_bytes: types.DeviceSize,
    storage_texel_buffer_offset_single_texel_alignment: types.Bool32,
    uniform_texel_buffer_offset_alignment_bytes: types.DeviceSize,
    uniform_texel_buffer_offset_single_texel_alignment: types.Bool32,
    max_buffer_size: types.DeviceSize,
};

pub const PipelineRenderingCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_rendering_create_info,
    p_next: ?*const anyopaque = null,
    view_mask: u32,
    color_attachment_count: u32,
    p_color_attachment_formats: ?[*]const types.Format,
    depth_attachment_format: types.Format,
    stencil_attachment_format: types.Format,
};

pub const RenderingLayerInfo = extern struct {
    s_type: types.StructureType = .rendering_fragment_shading_rate_attachment_info_khr, // Alias, needed to check correct value
    p_next: ?*const anyopaque = null,
    image_view: types.ImageView,
    image_layout: types.ImageLayout,
    resolve_mode: types.ResolveModeFlags,
    resolve_image_view: types.ImageView,
    resolve_image_layout: types.ImageLayout,
    load_op: types.AttachmentLoadOp,
    store_op: types.AttachmentStoreOp,
    clear_value: types.ClearValue,
};

pub const RenderingInfo = extern struct {
    s_type: types.StructureType = .rendering_info,
    p_next: ?*const anyopaque = null,
    flags: types.RenderingFlags,
    render_area: types.Rect2D,
    layer_count: u32,
    view_mask: u32,
    color_attachment_count: u32,
    p_color_attachments: ?[*]const RenderingAttachmentInfo,
    p_depth_attachment: ?*const RenderingAttachmentInfo,
    p_stencil_attachment: ?*const RenderingAttachmentInfo,
};

pub const RenderingAttachmentInfo = extern struct {
    s_type: types.StructureType = .rendering_attachment_info,
    p_next: ?*const anyopaque = null,
    image_view: types.ImageView,
    image_layout: types.ImageLayout,
    resolve_mode: types.ResolveModeFlags,
    resolve_image_view: types.ImageView,
    resolve_image_layout: types.ImageLayout,
    load_op: types.AttachmentLoadOp,
    store_op: types.AttachmentStoreOp,
    clear_value: types.ClearValue,
};

pub const MemoryBarrier2 = extern struct {
    s_type: types.StructureType = .memory_barrier_2,
    p_next: ?*const anyopaque = null,
    src_stage_mask: types.PipelineStageFlags2,
    src_access_mask: types.AccessFlags2,
    dst_stage_mask: types.PipelineStageFlags2,
    dst_access_mask: types.AccessFlags2,
};

pub const BufferMemoryBarrier2 = extern struct {
    s_type: types.StructureType = .buffer_memory_barrier_2,
    p_next: ?*const anyopaque = null,
    src_stage_mask: types.PipelineStageFlags2,
    src_access_mask: types.AccessFlags2,
    dst_stage_mask: types.PipelineStageFlags2,
    dst_access_mask: types.AccessFlags2,
    src_queue_family_index: u32,
    dst_queue_family_index: u32,
    buffer: types.Buffer,
    offset: types.DeviceSize,
    size: types.DeviceSize,
};

pub const ImageMemoryBarrier2 = extern struct {
    s_type: types.StructureType = .image_memory_barrier_2,
    p_next: ?*const anyopaque = null,
    src_stage_mask: types.PipelineStageFlags2,
    src_access_mask: types.AccessFlags2,
    dst_stage_mask: types.PipelineStageFlags2,
    dst_access_mask: types.AccessFlags2,
    old_layout: types.ImageLayout,
    new_layout: types.ImageLayout,
    src_queue_family_index: u32,
    dst_queue_family_index: u32,
    image: types.Image,
    subresource_range: types.ImageSubresourceRange,
};

pub const DependencyInfo = extern struct {
    s_type: types.StructureType = .dependency_info,
    p_next: ?*const anyopaque = null,
    dependency_flags: types.DependencyFlags,
    memory_barrier_count: u32,
    p_memory_barriers: ?[*]const MemoryBarrier2,
    buffer_memory_barrier_count: u32,
    p_buffer_memory_barriers: ?[*]const BufferMemoryBarrier2,
    image_memory_barrier_count: u32,
    p_image_memory_barriers: ?[*]const ImageMemoryBarrier2,
};

pub const PhysicalDeviceToolProperties = extern struct {
    s_type: types.StructureType = .physical_device_tool_properties,
    p_next: ?*anyopaque = null,
    name: [constants.MAX_EXTENSION_NAME_SIZE]u8,
    version: [constants.MAX_EXTENSION_NAME_SIZE]u8, // NOTE: It appears to be stringified version
    purposes: types.ToolPurposeFlags,
    description: [constants.MAX_DESCRIPTION_SIZE]u8,
    layer: [constants.MAX_EXTENSION_NAME_SIZE]u8,
};
