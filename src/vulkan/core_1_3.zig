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
    color_attachment_count: u32 = 0,
    p_color_attachment_formats: ?[*]const types.Format = null,
    depth_attachment_format: types.Format,
    stencil_attachment_format: types.Format,
};

pub const RenderingInfo = extern struct {
    s_type: types.StructureType = .rendering_info,
    p_next: ?*const anyopaque = null,
    flags: types.RenderingFlags = .{},
    render_area: types.Rect2D,
    layer_count: u32,
    view_mask: u32,
    color_attachment_count: u32 = 0,
    p_color_attachments: ?[*]const RenderingAttachmentInfo = null,
    p_depth_attachment: ?*const RenderingAttachmentInfo = null,
    p_stencil_attachment: ?*const RenderingAttachmentInfo = null,
};

pub const RenderingAttachmentInfo = extern struct {
    s_type: types.StructureType = .rendering_attachment_info,
    p_next: ?*const anyopaque = null,
    image_view: types.ImageView,
    image_layout: types.ImageLayout,
    resolve_mode: types.ResolveModeFlags = .{},
    resolve_image_view: types.ImageView,
    resolve_image_layout: types.ImageLayout,
    load_op: types.AttachmentLoadOp,
    store_op: types.AttachmentStoreOp,
    clear_value: types.ClearValue,
};

pub const MemoryBarrier2 = extern struct {
    s_type: types.StructureType = .memory_barrier_2,
    p_next: ?*const anyopaque = null,
    src_stage_mask: types.PipelineStageFlags2 = .{},
    src_access_mask: types.AccessFlags2 = .{},
    dst_stage_mask: types.PipelineStageFlags2 = .{},
    dst_access_mask: types.AccessFlags2 = .{},
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
    dependency_flags: types.DependencyFlags = .{},
    memory_barrier_count: u32 = 0,
    p_memory_barriers: ?[*]const MemoryBarrier2 = null,
    buffer_memory_barrier_count: u32 = 0,
    p_buffer_memory_barriers: ?[*]const BufferMemoryBarrier2 = null,
    image_memory_barrier_count: u32 = 0,
    p_image_memory_barriers: ?[*]const ImageMemoryBarrier2 = null,
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

// ============================================================================
// Individual Feature Structures (Vulkan 1.3)
// ============================================================================

pub const PhysicalDeviceShaderDemoteToHelperInvocationFeatures = extern struct {
    s_type: types.StructureType = .physical_device_shader_demote_to_helper_invocation_features,
    p_next: ?*const anyopaque = null,
    shader_demote_to_helper_invocation: types.Bool32,
};

pub const PhysicalDevicePrivateDataFeatures = extern struct {
    s_type: types.StructureType = .physical_device_private_data_features,
    p_next: ?*const anyopaque = null,
    private_data: types.Bool32,
};

pub const PhysicalDeviceShaderIntegerDotProductFeatures = extern struct {
    s_type: types.StructureType = .physical_device_shader_integer_dot_product_features,
    p_next: ?*const anyopaque = null,
    shader_integer_dot_product: types.Bool32,
};

pub const PhysicalDeviceSynchronization2Features = extern struct {
    s_type: types.StructureType = .physical_device_synchronization2_features,
    p_next: ?*const anyopaque = null,
    synchronization2: types.Bool32,
};

pub const PhysicalDeviceShaderTerminateInvocationFeatures = extern struct {
    s_type: types.StructureType = .physical_device_shader_terminate_invocation_features,
    p_next: ?*const anyopaque = null,
    shader_terminate_invocation: types.Bool32,
};

pub const PhysicalDeviceDynamicRenderingFeatures = extern struct {
    s_type: types.StructureType = .physical_device_dynamic_rendering_features,
    p_next: ?*const anyopaque = null,
    dynamic_rendering: types.Bool32,
};

pub const PhysicalDeviceShaderZeroInitializeWorkgroupMemoryFeatures = extern struct {
    s_type: types.StructureType = .physical_device_shader_zero_initialize_workgroup_memory_features,
    p_next: ?*const anyopaque = null,
    shader_zero_initialize_workgroup_memory: types.Bool32,
};

pub const PhysicalDeviceSubgroupSizeControlFeatures = extern struct {
    s_type: types.StructureType = .physical_device_subgroup_size_control_features,
    p_next: ?*const anyopaque = null,
    subgroup_size_control: types.Bool32,
};

pub const PhysicalDeviceSubgroupSizeControlProperties = extern struct {
    s_type: types.StructureType = .physical_device_subgroup_size_control_properties,
    p_next: ?*anyopaque = null,
    min_subgroup_size: u32,
    max_subgroup_size: u32,
    max_compute_workgroup_subgroups: u32,
    required_subgroup_size_stages: types.ShaderStageFlags,
};

pub const PhysicalDeviceMaintenance4Features = extern struct {
    s_type: types.StructureType = .physical_device_maintenance4_features,
    p_next: ?*const anyopaque = null,
    maintenance4: types.Bool32,
};

pub const PhysicalDeviceMaintenance4Properties = extern struct {
    s_type: types.StructureType = .physical_device_maintenance4_properties,
    p_next: ?*anyopaque = null,
    max_buffer_size: types.DeviceSize,
};

// ============================================================================
// Command Buffer Inheritance for Dynamic Rendering
// ============================================================================

pub const CommandBufferInheritanceRenderingInfo = extern struct {
    s_type: types.StructureType = .command_buffer_inheritance_rendering_info,
    p_next: ?*const anyopaque = null,
    flags: types.RenderingFlags = .{},
    view_mask: u32,
    color_attachment_count: u32 = 0,
    p_color_attachment_formats: ?[*]const types.Format = null,
    depth_attachment_format: types.Format,
    stencil_attachment_format: types.Format,
    rasterization_samples: types.SampleCountFlags,
};

// ============================================================================
// Copy Commands 2 Support
// ============================================================================

pub const CopyBufferInfo2 = extern struct {
    s_type: types.StructureType = .copy_buffer_info_2,
    p_next: ?*const anyopaque = null,
    src_buffer: types.Buffer,
    dst_buffer: types.Buffer,
    region_count: u32,
    p_regions: [*]const types.BufferCopy2,
};

pub const CopyImageInfo2 = extern struct {
    s_type: types.StructureType = .copy_image_info_2,
    p_next: ?*const anyopaque = null,
    src_image: types.Image,
    src_image_layout: types.ImageLayout,
    dst_image: types.Image,
    dst_image_layout: types.ImageLayout,
    region_count: u32,
    p_regions: [*]const types.ImageCopy2,
};

pub const CopyBufferToImageInfo2 = extern struct {
    s_type: types.StructureType = .copy_buffer_to_image_info_2,
    p_next: ?*const anyopaque = null,
    src_buffer: types.Buffer,
    dst_image: types.Image,
    dst_image_layout: types.ImageLayout,
    region_count: u32,
    p_regions: [*]const types.BufferImageCopy2,
};

pub const CopyImageToBufferInfo2 = extern struct {
    s_type: types.StructureType = .copy_image_to_buffer_info_2,
    p_next: ?*const anyopaque = null,
    src_image: types.Image,
    src_image_layout: types.ImageLayout,
    dst_buffer: types.Buffer,
    region_count: u32,
    p_regions: [*]const types.BufferImageCopy2,
};

pub const BlitImageInfo2 = extern struct {
    s_type: types.StructureType = .blit_image_info_2,
    p_next: ?*const anyopaque = null,
    src_image: types.Image,
    src_image_layout: types.ImageLayout,
    dst_image: types.Image,
    dst_image_layout: types.ImageLayout,
    region_count: u32,
    p_regions: [*]const types.ImageBlit2,
    filter: types.Filter,
};

// ============================================================================
// Submit Info 2 Support
// ============================================================================

pub const SubmitInfo2 = extern struct {
    s_type: types.StructureType = .submit_info_2,
    p_next: ?*const anyopaque = null,
    flags: types.SubmitFlags = .{},
    wait_semaphore_info_count: u32 = 0,
    p_wait_semaphore_infos: ?[*]const types.SemaphoreSubmitInfo = null,
    command_buffer_info_count: u32 = 0,
    p_command_buffer_infos: ?[*]const CommandBufferSubmitInfo = null,
    signal_semaphore_info_count: u32 = 0,
    p_signal_semaphore_infos: ?[*]const types.SemaphoreSubmitInfo = null,
};

pub const CommandBufferSubmitInfo = extern struct {
    s_type: types.StructureType = .command_buffer_submit_info,
    p_next: ?*const anyopaque = null,
    command_buffer: types.CommandBuffer,
    device_mask: u32,
};

// ============================================================================
// Enhanced Command Buffer Support
// ============================================================================

pub const SemaphoreSubmitInfo = extern struct {
    s_type: types.StructureType = .semaphore_submit_info,
    p_next: ?*const anyopaque = null,
    semaphore: types.Semaphore,
    value: u64,
    stage_mask: types.PipelineStageFlags2,
    device_index: u32,
};
