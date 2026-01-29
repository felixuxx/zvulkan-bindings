//! Core Vulkan 1.0 API structures and function signatures
//! This module contains all the structures needed for Vulkan 1.0 core functionality

const std = @import("std");

const c = @import("constants.zig");
const types = @import("types.zig");

// ============================================================================
// Application and Instance Structures
// ============================================================================

pub const ApplicationInfo = extern struct {
    s_type: types.StructureType = .application_info,
    p_next: ?*const anyopaque = null,
    p_application_name: ?[*:0]const u8 = null,
    application_version: u32 = 0,
    p_engine_name: ?[*:0]const u8 = null,
    engine_version: u32 = 0,
    api_version: u32 = c.API_VERSION_1_0,
};

pub const InstanceCreateInfo = extern struct {
    s_type: types.StructureType = .instance_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    p_application_info: ?*const ApplicationInfo = null,
    enabled_layer_count: u32 = 0,
    pp_enabled_layer_names: ?[*]const [*:0]const u8 = null,
    enabled_extension_count: u32 = 0,
    pp_enabled_extension_names: ?[*]const [*:0]const u8 = null,
};

pub const PhysicalDeviceProperties = extern struct {
    api_version: u32,
    driver_version: u32,
    vendor_id: u32,
    device_id: u32,
    device_type: PhysicalDeviceType,
    device_name: [c.MAX_PHYSICAL_DEVICE_NAME_SIZE]u8,
    pipeline_cache_uuid: [c.UUID_SIZE]u8,
    limits: PhysicalDeviceLimits,
    sparse_properties: PhysicalDeviceSparseProperties,
};

pub const PhysicalDeviceType = enum(i32) {
    other = 0,
    integrated_gpu = 1,
    discrete_gpu = 2,
    virtual_gpu = 3,
    cpu = 4,
    _,
};

pub const PhysicalDeviceLimits = extern struct {
    max_image_dimension_1d: u32,
    max_image_dimension_2d: u32,
    max_image_dimension_3d: u32,
    max_image_dimension_cube: u32,
    max_image_array_layers: u32,
    max_texel_buffer_elements: u32,
    max_uniform_buffer_range: u32,
    max_storage_buffer_range: u32,
    max_push_constants_size: u32,
    max_memory_allocation_count: u32,
    max_sampler_allocation_count: u32,
    buffer_image_granularity: types.DeviceSize,
    sparse_address_space_size: types.DeviceSize,
    max_bound_descriptor_sets: u32,
    max_per_stage_descriptor_samplers: u32,
    max_per_stage_descriptor_uniform_buffers: u32,
    max_per_stage_descriptor_storage_buffers: u32,
    max_per_stage_descriptor_sampled_images: u32,
    max_per_stage_descriptor_storage_images: u32,
    max_per_stage_descriptor_input_attachments: u32,
    max_per_stage_resources: u32,
    max_descriptor_set_samplers: u32,
    max_descriptor_set_uniform_buffers: u32,
    max_descriptor_set_uniform_buffers_dynamic: u32,
    max_descriptor_set_storage_buffers: u32,
    max_descriptor_set_storage_buffers_dynamic: u32,
    max_descriptor_set_sampled_images: u32,
    max_descriptor_set_storage_images: u32,
    max_descriptor_set_input_attachments: u32,
    max_vertex_input_attributes: u32,
    max_vertex_input_bindings: u32,
    max_vertex_input_attribute_offset: u32,
    max_vertex_input_binding_stride: u32,
    max_vertex_output_components: u32,
    max_tessellation_generation_level: u32,
    max_tessellation_patch_size: u32,
    max_tessellation_control_per_vertex_input_components: u32,
    max_tessellation_control_per_vertex_output_components: u32,
    max_tessellation_control_per_patch_output_components: u32,
    max_tessellation_control_total_output_components: u32,
    max_tessellation_evaluation_input_components: u32,
    max_tessellation_evaluation_output_components: u32,
    max_geometry_shader_invocations: u32,
    max_geometry_input_components: u32,
    max_geometry_output_components: u32,
    max_geometry_output_vertices: u32,
    max_geometry_total_output_components: u32,
    max_fragment_input_components: u32,
    max_fragment_output_attachments: u32,
    max_fragment_dual_src_attachments: u32,
    max_fragment_combined_output_resources: u32,
    max_compute_shared_memory_size: u32,
    max_compute_work_group_count: [3]u32,
    max_compute_work_group_invocations: u32,
    max_compute_work_group_size: [3]u32,
    sub_pixel_precision_bits: u32,
    sub_texel_precision_bits: u32,
    mipmap_precision_bits: u32,
    max_draw_indexed_index_value: u32,
    max_draw_indirect_count: u32,
    max_sampler_lod_bias: f32,
    max_sampler_anisotropy: f32,
    max_viewports: u32,
    max_viewport_dimensions: [2]u32,
    viewport_bounds_range: [2]f32,
    viewport_sub_pixel_bits: u32,
    min_memory_map_alignment: usize,
    min_texel_buffer_offset_alignment: types.DeviceSize,
    min_uniform_buffer_offset_alignment: types.DeviceSize,
    min_storage_buffer_offset_alignment: types.DeviceSize,
    min_texel_offset: i32,
    max_texel_offset: u32,
    min_texel_gather_offset: i32,
    max_texel_gather_offset: u32,
    min_interpolation_offset: f32,
    max_interpolation_offset: f32,
    sub_pixel_interpolation_offset_bits: u32,
    max_framebuffer_width: u32,
    max_framebuffer_height: u32,
    max_framebuffer_layers: u32,
    framebuffer_color_sample_counts: types.SampleCountFlags,
    framebuffer_depth_sample_counts: types.SampleCountFlags,
    framebuffer_stencil_sample_counts: types.SampleCountFlags,
    framebuffer_no_attachments_sample_counts: types.SampleCountFlags,
    max_color_attachments: u32,
    sampled_image_color_sample_counts: types.SampleCountFlags,
    sampled_image_integer_sample_counts: types.SampleCountFlags,
    sampled_image_depth_sample_counts: types.SampleCountFlags,
    sampled_image_stencil_sample_counts: types.SampleCountFlags,
    storage_image_sample_counts: types.SampleCountFlags,
    max_sample_mask_words: u32,
    timestamp_compute_and_graphics: types.Bool32,
    timestamp_period: f32,
    max_clip_distances: u32,
    max_cull_distances: u32,
    max_combined_clip_and_cull_distances: u32,
    discrete_queue_priorities: u32,
    point_size_range: [2]f32,
    line_width_range: [2]f32,
    point_size_granularity: f32,
    line_width_granularity: f32,
    strict_lines: types.Bool32,
    standard_sample_locations: types.Bool32,
    optimal_buffer_copy_offset_alignment: types.DeviceSize,
    optimal_buffer_copy_row_pitch_alignment: types.DeviceSize,
    non_coherent_atom_size: types.DeviceSize,
};

pub const PhysicalDeviceSparseProperties = extern struct {
    residency_standard_2d_block_shape: types.Bool32,
    residency_standard_2d_multisample_block_shape: types.Bool32,
    residency_standard_3d_block_shape: types.Bool32,
    residency_aligned_mip_size: types.Bool32,
    residency_non_resident_strict: types.Bool32,
};

pub const PhysicalDeviceFeatures = extern struct {
    robust_buffer_access: types.Bool32 = c.FALSE,
    full_draw_index_uint_32: types.Bool32 = c.FALSE,
    image_cube_array: types.Bool32 = c.FALSE,
    independent_blend: types.Bool32 = c.FALSE,
    geometry_shader: types.Bool32 = c.FALSE,
    tessellation_shader: types.Bool32 = c.FALSE,
    sample_rate_shading: types.Bool32 = c.FALSE,
    dual_src_blend: types.Bool32 = c.FALSE,
    logic_op: types.Bool32 = c.FALSE,
    multi_draw_indirect: types.Bool32 = c.FALSE,
    draw_indirect_first_instance: types.Bool32 = c.FALSE,
    depth_clamp: types.Bool32 = c.FALSE,
    depth_bias_clamp: types.Bool32 = c.FALSE,
    fill_mode_non_solid: types.Bool32 = c.FALSE,
    depth_bounds: types.Bool32 = c.FALSE,
    wide_lines: types.Bool32 = c.FALSE,
    large_points: types.Bool32 = c.FALSE,
    alpha_to_one: types.Bool32 = c.FALSE,
    multi_viewport: types.Bool32 = c.FALSE,
    sampler_anisotropy: types.Bool32 = c.FALSE,
    texture_compression_etc2: types.Bool32 = c.FALSE,
    texture_compression_astc_ldr: types.Bool32 = c.FALSE,
    texture_compression_bc: types.Bool32 = c.FALSE,
    occlusion_query_precise: types.Bool32 = c.FALSE,
    pipeline_statistics_query: types.Bool32 = c.FALSE,
    vertex_pipeline_stores_and_atomics: types.Bool32 = c.FALSE,
    fragment_stores_and_atomics: types.Bool32 = c.FALSE,
    shader_tessellation_and_geometry_point_size: types.Bool32 = c.FALSE,
    shader_image_gather_extended: types.Bool32 = c.FALSE,
    shader_storage_image_extended_formats: types.Bool32 = c.FALSE,
    shader_storage_image_multisample: types.Bool32 = c.FALSE,
    shader_storage_image_read_without_format: types.Bool32 = c.FALSE,
    shader_storage_image_write_without_format: types.Bool32 = c.FALSE,
    shader_uniform_buffer_array_dynamic_indexing: types.Bool32 = c.FALSE,
    shader_sampled_image_array_dynamic_indexing: types.Bool32 = c.FALSE,
    shader_storage_buffer_array_dynamic_indexing: types.Bool32 = c.FALSE,
    shader_storage_image_array_dynamic_indexing: types.Bool32 = c.FALSE,
    shader_clip_distance: types.Bool32 = c.FALSE,
    shader_cull_distance: types.Bool32 = c.FALSE,
    shader_float_64: types.Bool32 = c.FALSE,
    shader_int_64: types.Bool32 = c.FALSE,
    shader_int_16: types.Bool32 = c.FALSE,
    shader_resource_residency: types.Bool32 = c.FALSE,
    shader_resource_min_lod: types.Bool32 = c.FALSE,
    sparse_binding: types.Bool32 = c.FALSE,
    sparse_residency_buffer: types.Bool32 = c.FALSE,
    sparse_residency_image_2d: types.Bool32 = c.FALSE,
    sparse_residency_image_3d: types.Bool32 = c.FALSE,
    sparse_residency_2_samples: types.Bool32 = c.FALSE,
    sparse_residency_4_samples: types.Bool32 = c.FALSE,
    sparse_residency_8_samples: types.Bool32 = c.FALSE,
    sparse_residency_16_samples: types.Bool32 = c.FALSE,
    sparse_residency_aliased: types.Bool32 = c.FALSE,
    variable_multisample_rate: types.Bool32 = c.FALSE,
    inherited_queries: types.Bool32 = c.FALSE,
};

pub const PhysicalDeviceMemoryProperties = extern struct {
    memory_type_count: u32,
    memory_types: [c.MAX_MEMORY_TYPES]MemoryType,
    memory_heap_count: u32,
    memory_heaps: [c.MAX_MEMORY_HEAPS]MemoryHeap,
};

pub const MemoryType = extern struct {
    property_flags: types.MemoryPropertyFlags,
    heap_index: u32,
};

pub const MemoryHeap = extern struct {
    size: types.DeviceSize,
    flags: types.MemoryHeapFlags,
};

pub const QueueFamilyProperties = extern struct {
    queue_flags: types.QueueFlags,
    queue_count: u32,
    timestamp_valid_bits: u32,
    min_image_transfer_granularity: types.Extent3D,
};

// ============================================================================
// Device Structures
// ============================================================================

pub const DeviceQueueCreateInfo = extern struct {
    s_type: types.StructureType = .device_queue_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    queue_family_index: u32,
    queue_count: u32,
    p_queue_priorities: [*]const f32,
};

pub const DeviceCreateInfo = extern struct {
    s_type: types.StructureType = .device_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    queue_create_info_count: u32,
    p_queue_create_infos: [*]const DeviceQueueCreateInfo,
    enabled_layer_count: u32 = 0,
    pp_enabled_layer_names: ?[*]const [*:0]const u8 = null,
    enabled_extension_count: u32 = 0,
    pp_enabled_extension_names: ?[*]const [*:0]const u8 = null,
    p_enabled_features: ?*const PhysicalDeviceFeatures = null,
};

// ============================================================================
// Memory Structures
// ============================================================================

pub const MemoryAllocateInfo = extern struct {
    s_type: types.StructureType = .memory_allocate_info,
    p_next: ?*const anyopaque = null,
    allocation_size: types.DeviceSize,
    memory_type_index: u32,
};

pub const MappedMemoryRange = extern struct {
    s_type: types.StructureType = .mapped_memory_range,
    p_next: ?*const anyopaque = null,
    memory: types.DeviceMemory,
    offset: types.DeviceSize,
    size: types.DeviceSize,
};

// ============================================================================
// Image Subresource Structures
// ============================================================================

pub const ImageSubresource = extern struct {
    aspect_mask: types.ImageAspectFlags,
    mip_level: u32,
    array_layer: u32,
};

pub const ImageSubresourceLayers = extern struct {
    aspect_mask: types.ImageAspectFlags,
    mip_level: u32,
    base_array_layer: u32,
    layer_count: u32,
};

pub const ImageSubresourceRange = extern struct {
    aspect_mask: types.ImageAspectFlags,
    base_mip_level: u32,
    level_count: u32,
    base_array_layer: u32,
    layer_count: u32,
};

pub const SubresourceLayout = extern struct {
    offset: types.DeviceSize,
    size: types.DeviceSize,
    row_pitch: types.DeviceSize,
    array_pitch: types.DeviceSize,
    depth_pitch: types.DeviceSize,
};

pub const FormatProperties = extern struct {
    linear_tiling_features: types.FormatFeatureFlags = .{},
    optimal_tiling_features: types.FormatFeatureFlags = .{},
    buffer_features: types.FormatFeatureFlags = .{},
};

pub const ImageFormatProperties = extern struct {
    max_extent: types.Extent3D,
    max_mip_levels: u32,
    max_array_layers: u32,
    sample_counts: types.SampleCountFlags = .{},
    max_resource_size: types.DeviceSize,
};

// ============================================================================
// Sparse Memory Structures
// ============================================================================

pub const SparseImageFormatProperties = extern struct {
    aspect_mask: types.ImageAspectFlags,
    image_granularity: types.Extent3D,
    flags: types.SparseImageFormatFlags = .{},
};

pub const SparseImageMemoryRequirements = extern struct {
    format_properties: SparseImageFormatProperties,
    image_mip_tail_first_lod: u32,
    image_mip_tail_size: types.DeviceSize,
    image_mip_tail_offset: types.DeviceSize,
    image_mip_tail_stride: types.DeviceSize,
};

pub const SparseMemoryBind = extern struct {
    resource_offset: types.DeviceSize,
    size: types.DeviceSize,
    memory: types.DeviceMemory,
    memory_offset: types.DeviceSize,
    flags: types.SparseMemoryBindFlags = 0,
};

pub const SparseImageMemoryBind = extern struct {
    subresource: types.ImageSubresource,
    offset: types.Offset3D,
    extent: types.Extent3D,
    memory: types.DeviceMemory,
    memory_offset: types.DeviceSize,
    flags: types.SparseMemoryBindFlags = 0,
};

pub const SparseBufferMemoryBindInfo = extern struct {
    buffer: types.Buffer,
    bind_count: u32,
    p_binds: [*]const SparseMemoryBind,
};

pub const SparseImageOpaqueMemoryBindInfo = extern struct {
    image: types.Image,
    bind_count: u32,
    p_binds: [*]const SparseMemoryBind,
};

pub const SparseImageMemoryBindInfo = extern struct {
    image: types.Image,
    bind_count: u32,
    p_binds: [*]const SparseImageMemoryBind,
};

pub const BindSparseInfo = extern struct {
    s_type: types.StructureType = .bind_sparse_info,
    p_next: ?*const anyopaque = null,
    wait_semaphore_count: u32 = 0,
    p_wait_semaphores: ?[*]const types.Semaphore = null,
    buffer_bind_count: u32 = 0,
    p_buffer_binds: ?[*]const SparseBufferMemoryBindInfo = null,
    image_opaque_bind_count: u32 = 0,
    p_image_opaque_binds: ?[*]const SparseImageOpaqueMemoryBindInfo = null,
    image_bind_count: u32 = 0,
    p_image_binds: ?[*]const SparseImageMemoryBindInfo = null,
    signal_semaphore_count: u32 = 0,
    p_signal_semaphores: ?[*]const types.Semaphore = null,
};

// ============================================================================
// Buffer Structures
// ============================================================================

pub const BufferCreateInfo = extern struct {
    s_type: types.StructureType = .buffer_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.BufferCreateFlags = .{},
    size: types.DeviceSize,
    usage: types.BufferUsageFlags,
    sharing_mode: types.SharingMode = .exclusive,
    queue_family_index_count: u32 = 0,
    p_queue_family_indices: ?[*]const u32 = null,
};

pub const BufferViewCreateInfo = extern struct {
    s_type: types.StructureType = .buffer_view_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    buffer: types.Buffer,
    format: types.Format,
    offset: types.DeviceSize,
    range: types.DeviceSize,
};

// ============================================================================
// Image Structures
// ============================================================================

pub const ImageCreateInfo = extern struct {
    s_type: types.StructureType = .image_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.ImageCreateFlags = .{},
    image_type: types.ImageType,
    format: types.Format,
    extent: types.Extent3D,
    mip_levels: u32,
    array_layers: u32,
    samples: types.SampleCountFlags,
    tiling: types.ImageTiling,
    usage: types.ImageUsageFlags,
    sharing_mode: types.SharingMode = .exclusive,
    queue_family_index_count: u32 = 0,
    p_queue_family_indices: ?[*]const u32 = null,
    initial_layout: types.ImageLayout = .undefined,
};

pub const ImageViewCreateInfo = extern struct {
    s_type: types.StructureType = .image_view_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    image: types.Image,
    view_type: types.ImageViewType,
    format: types.Format,
    components: types.ComponentMapping = .{
        .r = .identity,
        .g = .identity,
        .b = .identity,
        .a = .identity,
    },
    subresource_range: types.ImageSubresourceRange,
};

// ============================================================================
// Command Buffer Structures
// ============================================================================

pub const CommandPoolCreateInfo = extern struct {
    s_type: types.StructureType = .command_pool_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.CommandPoolCreateFlags = .{},
    queue_family_index: u32,
};

pub const CommandBufferAllocateInfo = extern struct {
    s_type: types.StructureType = .command_buffer_allocate_info,
    p_next: ?*const anyopaque = null,
    command_pool: types.CommandPool,
    level: types.CommandBufferLevel,
    command_buffer_count: u32,
};

pub const CommandBufferBeginInfo = extern struct {
    s_type: types.StructureType = .command_buffer_begin_info,
    p_next: ?*const anyopaque = null,
    flags: types.CommandBufferUsageFlags = .{},
    p_inheritance_info: ?*const CommandBufferInheritanceInfo = null,
};

pub const CommandBufferInheritanceInfo = extern struct {
    s_type: types.StructureType = .command_buffer_inheritance_info,
    p_next: ?*const anyopaque = null,
    render_pass: types.RenderPass,
    subpass: u32,
    framebuffer: types.Framebuffer,
    occlusion_query_enable: types.Bool32,
    query_flags: u32,
    pipeline_statistics: u32,
};

// ============================================================================
// Synchronization Structures
// ============================================================================

pub const FenceCreateInfo = extern struct {
    s_type: types.StructureType = .fence_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
};

pub const SemaphoreCreateInfo = extern struct {
    s_type: types.StructureType = .semaphore_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
};

pub const SubmitInfo = extern struct {
    s_type: types.StructureType = .submit_info,
    p_next: ?*const anyopaque = null,
    wait_semaphore_count: u32 = 0,
    p_wait_semaphores: ?[*]const types.Semaphore = null,
    p_wait_dst_stage_mask: ?[*]const types.PipelineStageFlags = null,
    command_buffer_count: u32 = 0,
    p_command_buffers: ?[*]const types.CommandBuffer = null,
    signal_semaphore_count: u32 = 0,
    p_signal_semaphores: ?[*]const types.Semaphore = null,
};

// ============================================================================
// Shader and Pipeline Structures
// ============================================================================

pub const ShaderModuleCreateInfo = extern struct {
    s_type: types.StructureType = .shader_module_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    code_size: usize,
    p_code: [*]const u32,
};

pub const PipelineCacheCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_cache_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineCacheCreateFlags = 0,
    initial_data_size: usize = 0,
    p_initial_data: ?*const anyopaque = null,
};

pub const ComputePipelineCreateInfo = extern struct {
    s_type: types.StructureType = .compute_pipeline_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineCreateFlags = 0,
    stage: PipelineShaderStageCreateInfo,
    layout: types.PipelineLayout,
    base_pipeline_handle: types.Pipeline = 0,
    base_pipeline_index: i32,
};

pub const PipelineShaderStageCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_shader_stage_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    stage: u32, // VkShaderStageFlagBits - using u32 to match C header exactly
    module: types.ShaderModule,
    p_name: [*:0]const u8,
    p_specialization_info: ?*const SpecializationInfo = null,
};

pub const SpecializationInfo = extern struct {
    map_entry_count: u32,
    p_map_entries: [*]const SpecializationMapEntry,
    data_size: usize,
    p_data: *const anyopaque,
};

pub const SpecializationMapEntry = extern struct {
    constant_id: u32,
    offset: u32,
    size: usize,
};

pub const PipelineLayoutCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_layout_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    set_layout_count: u32 = 0,
    p_set_layouts: ?[*]const types.DescriptorSetLayout = null,
    push_constant_range_count: u32 = 0,
    p_push_constant_ranges: ?[*]const PushConstantRange = null,
};

pub const PushConstantRange = extern struct {
    stage_flags: types.ShaderStageFlags,
    offset: u32,
    size: u32,
};

// ============================================================================
// Render Pass Structures
// ============================================================================

pub const RenderPassCreateInfo = extern struct {
    s_type: types.StructureType = .render_pass_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    attachment_count: u32 = 0,
    p_attachments: ?[*]const AttachmentDescription = null,
    subpass_count: u32,
    p_subpasses: [*]const SubpassDescription,
    dependency_count: u32 = 0,
    p_dependencies: ?[*]const SubpassDependency = null,
};

pub const AttachmentDescription = extern struct {
    flags: u32 = 0,
    format: types.Format,
    samples: types.SampleCountFlags,
    load_op: types.AttachmentLoadOp,
    store_op: types.AttachmentStoreOp,
    stencil_load_op: types.AttachmentLoadOp,
    stencil_store_op: types.AttachmentStoreOp,
    initial_layout: types.ImageLayout,
    final_layout: types.ImageLayout,
};

pub const SubpassDescription = extern struct {
    flags: u32 = 0,
    pipeline_bind_point: types.PipelineBindPoint,
    input_attachment_count: u32 = 0,
    p_input_attachments: ?[*]const AttachmentReference = null,
    color_attachment_count: u32 = 0,
    p_color_attachments: ?[*]const AttachmentReference = null,
    p_resolve_attachments: ?[*]const AttachmentReference = null,
    p_depth_stencil_attachment: ?*const AttachmentReference = null,
    preserve_attachment_count: u32 = 0,
    p_preserve_attachments: ?[*]const u32 = null,
};

pub const AttachmentReference = extern struct {
    attachment: u32,
    layout: types.ImageLayout,
};

pub const SubpassDependency = extern struct {
    src_subpass: u32,
    dst_subpass: u32,
    src_stage_mask: types.PipelineStageFlags,
    dst_stage_mask: types.PipelineStageFlags,
    src_access_mask: types.AccessFlags,
    dst_access_mask: types.AccessFlags,
    dependency_flags: types.DependencyFlags,
};

pub const FramebufferCreateInfo = extern struct {
    s_type: types.StructureType = .framebuffer_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    render_pass: types.RenderPass,
    attachment_count: u32 = 0,
    p_attachments: ?[*]const types.ImageView = null,
    width: u32,
    height: u32,
    layers: u32,
};

pub const RenderPassBeginInfo = extern struct {
    s_type: types.StructureType = .render_pass_begin_info,
    p_next: ?*const anyopaque = null,
    render_pass: types.RenderPass,
    framebuffer: types.Framebuffer,
    render_area: types.Rect2D,
    clear_value_count: u32 = 0,
    p_clear_values: ?[*]const types.ClearValue = null,
};

pub const PipelineVertexInputStateCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_vertex_input_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineVertexInputStateCreateFlags = 0,
    vertex_binding_description_count: u32 = 0,
    p_vertex_binding_descriptions: ?[*]const types.VertexInputBindingDescription = null,
    vertex_attribute_description_count: u32 = 0,
    p_vertex_attribute_descriptions: ?[*]const types.VertexInputAttributeDescription = null,
};

pub const PipelineInputAssemblyStateCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_input_assembly_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineInputAssemblyStateCreateFlags = 0,
    topology: types.PrimitiveTopology = .point_list,
    primitive_restart_enable: types.Bool32 = 0,
};

pub const PipelineRasterizationStateCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_rasterization_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineRasterizationStateCreateFlags = 0,
    depth_clamp_enable: types.Bool32 = 0,
    rasterizer_discard_enable: types.Bool32 = 0,
    polygon_mode: types.PolygonMode = .fill,
    cull_mode: types.CullModeFlags = .{ .none = true },
    front_face: types.FrontFace = .counter_clockwise,
    depth_bias_enable: types.Bool32 = 0,
    depth_bias_constant_factor: f32 = 0.0,
    depth_bias_clamp: f32 = 0.0,
    depth_bias_slope_factor: f32 = 0.0,
    line_width: f32 = 1.0,
};

pub const PipelineMultisampleStateCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_multisample_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineMultisampleStateCreateFlags = 0,
    rasterization_samples: types.SampleCountFlagBits = .@"1",
    sample_shading_enable: types.Bool32 = 0,
    min_sample_shading: f32 = 0.0,
    p_sample_mask: ?[*]const types.SampleMask = null,
    alpha_to_coverage_enable: types.Bool32 = 0,
    alpha_to_one_enable: types.Bool32 = 0,
};

pub const PipelineColorBlendAttachmentState = extern struct {
    blend_enable: types.Bool32 = 0,
    src_color_blend_factor: types.BlendFactor = .zero,
    dst_color_blend_factor: types.BlendFactor = .zero,
    color_blend_op: types.BlendOp = .add,
    src_alpha_blend_factor: types.BlendFactor = .zero,
    dst_alpha_blend_factor: types.BlendFactor = .zero,
    alpha_blend_op: types.BlendOp = .add,
    color_write_mask: types.ColorComponentFlags = .{ .r = true, .g = true, .b = true, .a = true },
};

pub const PipelineColorBlendStateCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_color_blend_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineColorBlendStateCreateFlags = 0,
    logic_op_enable: types.Bool32 = 0,
    logic_op: types.LogicOp = .copy,
    attachment_count: u32 = 0,
    p_attachments: ?[*]const PipelineColorBlendAttachmentState = null,
    blend_constants: [4]f32 = [_]f32{ 0.0, 0.0, 0.0, 0.0 },
};

pub const PipelineViewportStateCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_viewport_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineViewportStateCreateFlags = 0,
    viewport_count: u32 = 0,
    p_viewports: ?[*]const types.Viewport = null,
    scissor_count: u32 = 0,
    p_scissors: ?[*]const types.Rect2D = null,
};

pub const PipelineTessellationStateCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_tessellation_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineTessellationStateCreateFlags = 0,
    patch_control_points: u32 = 0,
};

pub const PipelineDepthStencilStateCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_depth_stencil_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineDepthStencilStateCreateFlags = 0,
    depth_test_enable: types.Bool32 = 0,
    depth_write_enable: types.Bool32 = 0,
    depth_compare_op: types.CompareOp = .never,
    depth_bounds_test_enable: types.Bool32 = 0,
    min_depth_bounds: f32 = 0.0,
    max_depth_bounds: f32 = 1.0,
    stencil_test_enable: types.Bool32 = 0,
    front: types.StencilOpState = std.mem.zeroes(types.StencilOpState),
    back: types.StencilOpState = std.mem.zeroes(types.StencilOpState),
};

pub const DynamicState = enum(u32) {
    viewport = 0,
    scissor = 1,
    line_width = 2,
    depth_bias = 3,
    blend_constants = 4,
    depth_bounds = 5,
    stencil_compare_mask = 6,
    stencil_write_mask = 7,
    stencil_reference = 8,
};

pub const PipelineDynamicStateCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_dynamic_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineDynamicStateCreateFlags = 0,
    dynamic_state_count: u32 = 0,
    p_dynamic_states: ?[*]const DynamicState = null,
};

pub const GraphicsPipelineCreateInfo = extern struct {
    s_type: types.StructureType = .graphics_pipeline_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.PipelineCreateFlags = 0,
    stage_count: u32 = 0,
    p_stages: ?[*]const PipelineShaderStageCreateInfo = null,
    p_vertex_input_state: ?*const PipelineVertexInputStateCreateInfo = null,
    p_input_assembly_state: ?*const PipelineInputAssemblyStateCreateInfo = null,
    p_tessellation_state: ?*const PipelineTessellationStateCreateInfo = null,
    p_viewport_state: ?*const PipelineViewportStateCreateInfo = null,
    p_rasterization_state: ?*const PipelineRasterizationStateCreateInfo = null,
    p_multisample_state: ?*const PipelineMultisampleStateCreateInfo = null,
    p_depth_stencil_state: ?*const PipelineDepthStencilStateCreateInfo = null,
    p_color_blend_state: ?*const PipelineColorBlendStateCreateInfo = null,
    p_dynamic_state: ?*const PipelineDynamicStateCreateInfo = null,
    layout: types.PipelineLayout,
    render_pass: types.RenderPass,
    subpass: u32 = 0,
    base_pipeline_handle: types.Pipeline,
    base_pipeline_index: i32 = -1,
};

// ============================================================================
// Descriptor Management Structures
// ============================================================================

pub const DescriptorSetLayoutCreateInfo = extern struct {
    s_type: types.StructureType = .descriptor_set_layout_create_info,
    p_next: ?*const anyopaque = null,
    flags: types.DescriptorSetLayoutCreateFlags = 0,
    binding_count: u32 = 0,
    p_bindings: ?[*]const types.DescriptorSetLayoutBinding = null,
};

pub const DescriptorPoolCreateInfo = extern struct {
    s_type: types.StructureType = .descriptor_pool_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    max_sets: u32 = 0,
    pool_size_count: u32 = 0,
    p_pool_sizes: ?[*]const DescriptorPoolSize = null,
};

pub const DescriptorPoolSize = extern struct {
    type: types.DescriptorType,
    descriptor_count: u32,
};

pub const DescriptorSetAllocateInfo = extern struct {
    s_type: types.StructureType = .descriptor_set_allocate_info,
    p_next: ?*const anyopaque = null,
    descriptor_pool: types.DescriptorPool,
    descriptor_set_count: u32 = 0,
    p_set_layouts: ?[*]const types.DescriptorSetLayout = null,
};

pub const WriteDescriptorSet = extern struct {
    s_type: types.StructureType = .write_descriptor_set,
    p_next: ?*const anyopaque = null,
    dst_set: types.DescriptorSet,
    dst_binding: u32 = 0,
    dst_array_element: u32 = 0,
    descriptor_count: u32 = 0,
    descriptor_type: types.DescriptorType,
    p_image_info: ?[*]const DescriptorImageInfo = null,
    p_buffer_info: ?[*]const DescriptorBufferInfo = null,
    p_texel_buffer_view: ?[*]const types.BufferView = null,
};

pub const CopyDescriptorSet = extern struct {
    s_type: types.StructureType = .copy_descriptor_set,
    p_next: ?*const anyopaque = null,
    src_set: types.DescriptorSet,
    src_binding: u32 = 0,
    dst_set: types.DescriptorSet,
    dst_binding: u32 = 0,
    descriptor_count: u32 = 0,
};

pub const DescriptorImageInfo = extern struct {
    sampler: types.Sampler,
    image_view: types.ImageView,
    image_layout: types.ImageLayout = .shader_read_only_optimal,
};

pub const DescriptorBufferInfo = extern struct {
    buffer: types.Buffer,
    offset: u64 = 0,
    range: u64 = 0xFFFFFFFFFFFFFFFF, // WHOLE_SIZE equivalent
};

test "descriptor structures compilation" {
    const layout_info = DescriptorSetLayoutCreateInfo{};
    const pool_info = DescriptorPoolCreateInfo{};
    const alloc_info = DescriptorSetAllocateInfo{
        .descriptor_pool = undefined,
    };
    const write_info = WriteDescriptorSet{
        .dst_set = undefined,
        .descriptor_type = undefined,
    };
    const copy_info = CopyDescriptorSet{
        .src_set = undefined,
        .dst_set = undefined,
    };
    const sampler_info = SamplerCreateInfo{
        .min_filter = .linear,
        .mag_filter = .linear,
        .address_mode_u = .repeat,
        .address_mode_v = .repeat,
        .address_mode_w = .repeat,
        .compare_op = .always,
        .mipmap_mode = .linear,
    };
    const desc_image_info = DescriptorImageInfo{
        .sampler = undefined,
        .image_view = undefined,
    };
    const desc_buffer_info = DescriptorBufferInfo{
        .buffer = undefined,
    };

    // Test that structures can be instantiated
    _ = layout_info;
    _ = pool_info;
    _ = alloc_info;
    _ = write_info;
    _ = copy_info;
    _ = sampler_info;
    _ = desc_image_info;
    _ = desc_buffer_info;
}

// ============================================================================
// Indirect Command Structures
// ============================================================================

pub const DrawIndirectCommand = extern struct {
    vertex_count: u32,
    instance_count: u32,
    first_vertex: u32,
    first_instance: u32,
};

pub const DrawIndexedIndirectCommand = extern struct {
    index_count: u32,
    instance_count: u32,
    first_index: u32,
    vertex_offset: i32,
    first_instance: u32,
};

pub const DispatchIndirectCommand = extern struct {
    x: u32,
    y: u32,
    z: u32,
};

// ============================================================================
// Command Buffer Recording Structures
// ============================================================================

pub const MemoryBarrier = extern struct {
    s_type: types.StructureType = .memory_barrier,
    p_next: ?*const anyopaque = null,
    src_access_mask: types.AccessFlags,
    dst_access_mask: types.AccessFlags,
};

pub const BufferMemoryBarrier = extern struct {
    s_type: types.StructureType = .buffer_memory_barrier,
    p_next: ?*const anyopaque = null,
    src_access_mask: types.AccessFlags,
    dst_access_mask: types.AccessFlags,
    src_queue_family_index: u32 = 0,
    dst_queue_family_index: u32 = 0,
    buffer: types.Buffer,
    offset: u64 = 0,
    size: u64 = 0xFFFFFFFFFFFFFFFF, // WHOLE_SIZE equivalent
};

pub const ImageMemoryBarrier = extern struct {
    s_type: types.StructureType = .image_memory_barrier,
    p_next: ?*const anyopaque = null,
    src_access_mask: types.AccessFlags,
    dst_access_mask: types.AccessFlags,
    old_layout: types.ImageLayout,
    new_layout: types.ImageLayout,
    src_queue_family_index: u32 = 0,
    dst_queue_family_index: u32 = 0,
    image: types.Image,
    subresource_range: types.ImageSubresourceRange,
};

pub const BufferCopy = extern struct {
    src_offset: u64 = 0,
    dst_offset: u64 = 0,
    size: u64 = 0,
};

pub const ImageCopy = extern struct {
    src_subresource: types.ImageSubresourceLayers,
    src_offset: types.Offset3D,
    dst_subresource: types.ImageSubresourceLayers,
    dst_offset: types.Offset3D,
    extent: types.Extent3D,
};

pub const BufferImageCopy = extern struct {
    buffer_offset: u64 = 0,
    buffer_row_length: u32 = 0,
    buffer_image_height: u32 = 0,
    image_subresource: types.ImageSubresourceLayers,
    image_offset: types.Offset3D,
    image_extent: types.Extent3D,
};

pub const ImageBlit = extern struct {
    src_subresource: types.ImageSubresourceLayers,
    src_offsets: [2]types.Offset3D,
    dst_subresource: types.ImageSubresourceLayers,
    dst_offsets: [2]types.Offset3D,
};

pub const ImageResolve = extern struct {
    src_subresource: types.ImageSubresourceLayers,
    src_offset: types.Offset3D,
    dst_subresource: types.ImageSubresourceLayers,
    dst_offset: types.Offset3D,
    extent: types.Extent3D,
};

pub const ClearAttachment = extern struct {
    aspect_mask: types.ImageAspectFlags,
    color_attachment: u32 = 0,
    image_view: types.ImageView,
    clear_value: types.ClearValue,
};

pub const ClearRect = extern struct {
    rect: types.Rect2D,
    base_array_layer: u32 = 0,
    layer_count: u32 = 1,
};

pub const SamplerCreateInfo = extern struct {
    s_type: types.StructureType = .sampler_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    min_filter: types.Filter,
    mag_filter: types.Filter,
    address_mode_u: types.SamplerAddressMode,
    address_mode_v: types.SamplerAddressMode,
    address_mode_w: types.SamplerAddressMode,
    anisotropy_enable: types.Bool32 = 0,
    max_anisotropy: f32 = 0.0,
    border_color: types.BorderColor = .float_transparent_black,
    unnormalized_coordinates: types.Bool32 = 0,
    compare_enable: types.Bool32 = 0,
    compare_op: types.CompareOp,
    mipmap_mode: types.SamplerMipmapMode,
    mip_lod_bias: f32 = 0.0,
    min_lod: f32 = 0.0,
    max_lod: f32 = 0.0,
};

// ============================================================================
// Query and Event Structures
// ============================================================================

pub const QueryPoolCreateInfo = extern struct {
    s_type: types.StructureType = .query_pool_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    query_type: types.QueryType,
    query_count: u32 = 0,
    pipeline_statistics: u32 = 0,
};

pub const EventCreateInfo = extern struct {
    s_type: types.StructureType = .event_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
};

// ============================================================================
// Additional Pipeline Structures
// ============================================================================
