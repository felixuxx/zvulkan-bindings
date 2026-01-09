//! Core Vulkan 1.0 API structures and function signatures
//! This module contains all the structures needed for Vulkan 1.0 core functionality

const types = @import("types.zig");
const c = @import("constants.zig");

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
    full_draw_index_uint32: types.Bool32 = c.FALSE,
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
    shader_float64: types.Bool32 = c.FALSE,
    shader_int64: types.Bool32 = c.FALSE,
    shader_int16: types.Bool32 = c.FALSE,
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
    command_buffer_count: u32,
    p_command_buffers: [*]const types.CommandBuffer,
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

pub const PipelineShaderStageCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_shader_stage_create_info,
    p_next: ?*const anyopaque = null,
    flags: u32 = 0,
    stage: types.ShaderStageFlags,
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
    attachment_count: u32,
    p_attachments: [*]const types.ImageView,
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
