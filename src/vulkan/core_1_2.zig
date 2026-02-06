//! Vulkan 1.2 Core Structures and Functions

const types = @import("types.zig");
const constants = @import("constants.zig");

// ============================================================================
// Structures
// ============================================================================

pub const PhysicalDeviceVulkan11Features = extern struct {
    s_type: types.StructureType = .physical_device_vulkan_1_1_features,
    p_next: ?*anyopaque = null,
    storage_buffer_16_bit_access: types.Bool32,
    uniform_and_storage_buffer_16_bit_access: types.Bool32,
    storage_push_constant_16_bit: types.Bool32,
    storage_input_output_16_bit: types.Bool32,
    multiview: types.Bool32,
    multiview_geometry_shader: types.Bool32,
    multiview_tessellation_shader: types.Bool32,
    variable_pointers_storage_buffer: types.Bool32,
    variable_pointers: types.Bool32,
    protected_memory: types.Bool32,
    sampler_ycbcr_conversion: types.Bool32,
    shader_draw_parameters: types.Bool32,
};

pub const PhysicalDeviceVulkan11Properties = extern struct {
    s_type: types.StructureType = .physical_device_vulkan_1_1_properties,
    p_next: ?*anyopaque = null,
    device_uuid: [constants.UUID_SIZE]u8,
    driver_uuid: [constants.UUID_SIZE]u8,
    device_luid: [constants.LUID_SIZE]u8,
    device_node_mask: u32,
    device_luid_valid: types.Bool32,
    subgroup_size: u32,
    subgroup_supported_stages: types.ShaderStageFlags,
    subgroup_supported_operations: types.SubgroupFeatureFlags,
    subgroup_quad_operations_in_all_stages: types.Bool32,
    point_clipping_behavior: types.PointClippingBehavior,
    max_multiview_view_count: u32,
    max_multiview_instance_index: u32,
    protected_no_fault: types.Bool32,
    max_per_set_descriptors: u32,
    max_memory_allocation_size: types.DeviceSize,
};

pub const PhysicalDeviceVulkan12Features = extern struct {
    s_type: types.StructureType = .physical_device_vulkan_1_2_features,
    p_next: ?*anyopaque = null,
    sampler_mirror_clamp_to_edge: types.Bool32,
    draw_indirect_count: types.Bool32,
    storage_buffer_8_bit_access: types.Bool32,
    uniform_and_storage_buffer_8_bit_access: types.Bool32,
    storage_push_constant_8_bit: types.Bool32,
    shader_buffer_int64_atomics: types.Bool32,
    shader_shared_int64_atomics: types.Bool32,
    shader_float16: types.Bool32,
    shader_int8: types.Bool32,
    descriptor_indexing: types.Bool32,
    shader_input_attachment_array_dynamic_indexing: types.Bool32,
    shader_uniform_texel_buffer_array_dynamic_indexing: types.Bool32,
    shader_storage_texel_buffer_array_dynamic_indexing: types.Bool32,
    shader_uniform_buffer_array_non_uniform_indexing: types.Bool32,
    shader_sampled_image_array_non_uniform_indexing: types.Bool32,
    shader_storage_buffer_array_non_uniform_indexing: types.Bool32,
    shader_storage_image_array_non_uniform_indexing: types.Bool32,
    shader_input_attachment_array_non_uniform_indexing: types.Bool32,
    shader_uniform_texel_buffer_array_non_uniform_indexing: types.Bool32,
    shader_storage_texel_buffer_array_non_uniform_indexing: types.Bool32,
    descriptor_binding_uniform_buffer_update_after_bind: types.Bool32,
    descriptor_binding_sampled_image_update_after_bind: types.Bool32,
    descriptor_binding_storage_image_update_after_bind: types.Bool32,
    descriptor_binding_storage_buffer_update_after_bind: types.Bool32,
    descriptor_binding_uniform_texel_buffer_update_after_bind: types.Bool32,
    descriptor_binding_storage_texel_buffer_update_after_bind: types.Bool32,
    descriptor_binding_update_unused_while_pending: types.Bool32,
    descriptor_binding_partially_bound: types.Bool32,
    descriptor_binding_variable_descriptor_count: types.Bool32,
    runtime_descriptor_array: types.Bool32,
    sampler_filter_minmax: types.Bool32,
    scalar_block_layout: types.Bool32,
    imageless_framebuffer: types.Bool32,
    uniform_buffer_standard_layout: types.Bool32,
    shader_subgroup_extended_types: types.Bool32,
    separate_depth_stencil_layouts: types.Bool32,
    host_query_reset: types.Bool32,
    timeline_semaphore: types.Bool32,
    buffer_device_address: types.Bool32,
    buffer_device_address_capture_replay: types.Bool32,
    buffer_device_address_multi_device: types.Bool32,
    vulkan_memory_model: types.Bool32,
    vulkan_memory_model_device_scope: types.Bool32,
    vulkan_memory_model_availability_visibility_chains: types.Bool32,
    shader_output_viewport_index: types.Bool32,
    shader_output_layer: types.Bool32,
    subgroup_broadcast_dynamic_id: types.Bool32,
};

pub const PhysicalDeviceVulkan12Properties = extern struct {
    s_type: types.StructureType = .physical_device_vulkan_1_2_properties,
    p_next: ?*anyopaque = null,
    driver_id: types.DriverId,
    driver_name: [constants.MAX_DRIVER_NAME_SIZE]u8,
    driver_info: [constants.MAX_DRIVER_INFO_SIZE]u8,
    conformance_version: types.ConformanceVersion,
    denorm_behavior_independence: types.ShaderFloatControlsIndependence,
    rounding_mode_independence: types.ShaderFloatControlsIndependence,
    shader_signed_zero_inf_nan_preserve_float16: types.Bool32,
    shader_signed_zero_inf_nan_preserve_float32: types.Bool32,
    shader_signed_zero_inf_nan_preserve_float64: types.Bool32,
    shader_denorm_preserve_float16: types.Bool32,
    shader_denorm_preserve_float32: types.Bool32,
    shader_denorm_preserve_float64: types.Bool32,
    shader_denorm_flush_to_zero_float16: types.Bool32,
    shader_denorm_flush_to_zero_float32: types.Bool32,
    shader_denorm_flush_to_zero_float64: types.Bool32,
    shader_rounding_mode_rte_float16: types.Bool32,
    shader_rounding_mode_rte_float32: types.Bool32,
    shader_rounding_mode_rte_float64: types.Bool32,
    shader_rounding_mode_rtz_float16: types.Bool32,
    shader_rounding_mode_rtz_float32: types.Bool32,
    shader_rounding_mode_rtz_float64: types.Bool32,
    max_update_after_bind_descriptors_in_all_pools: u32,
    shader_uniform_buffer_array_non_uniform_indexing_native: types.Bool32,
    shader_sampled_image_array_non_uniform_indexing_native: types.Bool32,
    shader_storage_buffer_array_non_uniform_indexing_native: types.Bool32,
    shader_storage_image_array_non_uniform_indexing_native: types.Bool32,
    shader_input_attachment_array_non_uniform_indexing_native: types.Bool32,
    robust_buffer_access_update_after_bind: types.Bool32,
    quad_divergent_implicit_lod: types.Bool32,
    max_per_stage_descriptor_update_after_bind_samplers: u32,
    max_per_stage_descriptor_update_after_bind_uniform_buffers: u32,
    max_per_stage_descriptor_update_after_bind_storage_buffers: u32,
    max_per_stage_descriptor_update_after_bind_sampled_images: u32,
    max_per_stage_descriptor_update_after_bind_storage_images: u32,
    max_per_stage_descriptor_update_after_bind_input_attachments: u32,
    max_descriptor_set_update_after_bind_samplers: u32,
    max_descriptor_set_update_after_bind_uniform_buffers: u32,
    max_descriptor_set_update_after_bind_uniform_buffers_dynamic: u32,
    max_descriptor_set_update_after_bind_storage_buffers: u32,
    max_descriptor_set_update_after_bind_storage_buffers_dynamic: u32,
    max_descriptor_set_update_after_bind_sampled_images: u32,
    max_descriptor_set_update_after_bind_storage_images: u32,
    max_descriptor_set_update_after_bind_input_attachments: u32,
    supported_depth_resolve_modes: types.ResolveModeFlags,
    supported_stencil_resolve_modes: types.ResolveModeFlags,
    independent_resolve_none: types.Bool32,
    independent_resolve: types.Bool32,
    filter_minmax_single_component_formats: types.Bool32,
    filter_minmax_image_component_mapping: types.Bool32,
    max_timeline_semaphore_value_difference: u64,
    framebuffer_integer_color_sample_counts: types.SampleCountFlags,
};

pub const SemaphoreTypeCreateInfo = extern struct {
    s_type: types.StructureType = .semaphore_type_create_info,
    p_next: ?*const anyopaque = null,
    semaphore_type: types.SemaphoreType,
    initial_value: u64,
};

pub const TimelineSemaphoreSubmitInfo = extern struct {
    s_type: types.StructureType = .timeline_semaphore_submit_info,
    p_next: ?*const anyopaque = null,
    wait_semaphore_value_count: u32,
    p_wait_semaphore_values: ?[*]const u64,
    signal_semaphore_value_count: u32,
    p_signal_semaphore_values: ?[*]const u64,
};

pub const SemaphoreWaitInfo = extern struct {
    s_type: types.StructureType = .semaphore_wait_info,
    p_next: ?*const anyopaque = null,
    flags: types.SemaphoreWaitFlags,
    semaphore_count: u32,
    p_semaphores: ?[*]const types.Semaphore,
    p_values: ?[*]const u64,
};

pub const SemaphoreSignalInfo = extern struct {
    s_type: types.StructureType = .semaphore_signal_info,
    p_next: ?*const anyopaque = null,
    semaphore: types.Semaphore,
    value: u64,
};

pub const BufferDeviceAddressInfo = extern struct {
    s_type: types.StructureType = .buffer_device_address_info,
    p_next: ?*const anyopaque = null,
    buffer: types.Buffer,
};

pub const DeviceMemoryOpaqueCaptureAddressInfo = extern struct {
    s_type: types.StructureType = .device_memory_opaque_capture_address_info,
    p_next: ?*const anyopaque = null,
    memory: types.DeviceMemory,
};

// ============================================================================
// Extended Render Pass Structures (Vulkan 1.2)
// ============================================================================

pub const RenderPassCreateInfo2 = extern struct {
    s_type: types.StructureType = .render_pass_create_info_2,
    p_next: ?*const anyopaque = null,
    flags: types.RenderPassCreateFlags,
    attachment_count: u32,
    p_attachments: ?[*]const AttachmentDescription2,
    subpass_count: u32,
    p_subpasses: ?[*]const SubpassDescription2,
    dependency_count: u32,
    p_dependencies: ?[*]const SubpassDependency2,
    correlated_view_mask_count: u32,
    p_correlated_view_masks: ?[*]const u32,
};

pub const AttachmentDescription2 = extern struct {
    s_type: types.StructureType = .attachment_description_2,
    p_next: ?*const anyopaque = null,
    flags: types.AttachmentDescriptionFlags,
    format: types.Format,
    samples: types.SampleCountFlagBits,
    load_op: types.AttachmentLoadOp,
    store_op: types.AttachmentStoreOp,
    stencil_load_op: types.AttachmentLoadOp,
    stencil_store_op: types.AttachmentStoreOp,
    initial_layout: types.ImageLayout,
    final_layout: types.ImageLayout,
};

pub const SubpassDescription2 = extern struct {
    s_type: types.StructureType = .subpass_description_2,
    p_next: ?*const anyopaque = null,
    flags: types.SubpassDescriptionFlags,
    pipeline_bind_point: types.PipelineBindPoint,
    view_mask: u32,
    input_attachment_count: u32,
    p_input_attachments: ?[*]const AttachmentReference2,
    color_attachment_count: u32,
    p_color_attachments: ?[*]const AttachmentReference2,
    p_resolve_attachments: ?[*]const AttachmentReference2,
    p_depth_stencil_attachment: ?*const AttachmentReference2,
    preserve_attachment_count: u32,
    p_preserve_attachments: ?[*]const u32,
};

pub const SubpassDependency2 = extern struct {
    s_type: types.StructureType = .subpass_dependency_2,
    p_next: ?*const anyopaque = null,
    src_subpass: u32,
    dst_subpass: u32,
    src_stage_mask: types.PipelineStageFlags,
    dst_stage_mask: types.PipelineStageFlags,
    src_access_mask: types.AccessFlags,
    dst_access_mask: types.AccessFlags,
    dependency_flags: types.DependencyFlags,
    view_offset: i32,
};

pub const AttachmentReference2 = extern struct {
    s_type: types.StructureType = .attachment_reference_2,
    p_next: ?*const anyopaque = null,
    attachment: u32,
    layout: types.ImageLayout,
    aspect_mask: types.ImageAspectFlags,
};

// ============================================================================
// Input Attachment Aspect Support
// ============================================================================

pub const InputAttachmentAspectReference = extern struct {
    subpass: u32,
    input_attachment_index: u32,
    aspect_mask: types.ImageAspectFlags,
};

pub const RenderPassInputAttachmentAspectCreateInfo = extern struct {
    s_type: types.StructureType = .render_pass_input_attachment_aspect_create_info,
    p_next: ?*const anyopaque = null,
    aspect_reference_count: u32,
    p_aspect_references: ?[*]const InputAttachmentAspectReference,
};

// ============================================================================
// Image Format List Support
// ============================================================================

pub const ImageFormatListCreateInfo = extern struct {
    s_type: types.StructureType = .image_format_list_create_info,
    p_next: ?*const anyopaque = null,
    view_format_count: u32,
    p_view_formats: ?[*]const types.Format,
};

// ============================================================================
// Device Group Support
// ============================================================================

pub const DeviceGroupDeviceCreateInfo = extern struct {
    s_type: types.StructureType = .device_group_device_create_info,
    p_next: ?*const anyopaque = null,
    physical_device_count: u32,
    p_physical_devices: ?[*]const types.PhysicalDevice,
};

pub const DeviceGroupSubmitInfo = extern struct {
    s_type: types.StructureType = .device_group_submit_info,
    p_next: ?*const anyopaque = null,
    wait_semaphore_count: u32,
    p_wait_semaphore_device_indices: ?[*]const u32,
    command_buffer_count: u32,
    p_command_buffer_device_masks: ?[*]const u32,
    signal_semaphore_count: u32,
    p_signal_semaphore_device_indices: ?[*]const u32,
};

// ============================================================================
// Bind Memory 2 Support
// ============================================================================

pub const BindBufferMemoryInfo = extern struct {
    s_type: types.StructureType = .bind_buffer_memory_info,
    p_next: ?*const anyopaque = null,
    buffer: types.Buffer,
    memory: types.DeviceMemory,
    memory_offset: types.DeviceSize,
};

pub const BindImageMemoryInfo = extern struct {
    s_type: types.StructureType = .bind_image_memory_info,
    p_next: ?*const anyopaque = null,
    image: types.Image,
    memory: types.DeviceMemory,
    memory_offset: types.DeviceSize,
};

pub const BindBufferMemoryDeviceGroupInfo = extern struct {
    s_type: types.StructureType = .bind_buffer_memory_device_group_info,
    p_next: ?*const anyopaque = null,
    device_index_count: u32 = 0,
    p_device_indices: ?[*]const u32 = null,
};

pub const BindImageMemoryDeviceGroupInfo = extern struct {
    s_type: types.StructureType = .bind_image_memory_device_group_info,
    p_next: ?*const anyopaque = null,
    device_index_count: u32 = 0,
    p_device_indices: ?[*]const u32 = null,
    split_instance_bind_region_count: u32 = 0,
    p_split_instance_bind_regions: ?[*]const types.Rect2D = null,
};

pub const MemoryDedicatedRequirements = extern struct {
    s_type: types.StructureType = .memory_dedicated_requirements,
    p_next: ?*const anyopaque = null,
    prefers_dedicated_allocation: types.Bool32,
    requires_dedicated_allocation: types.Bool32,
};

pub const MemoryDedicatedAllocateInfo = extern struct {
    s_type: types.StructureType = .memory_dedicated_allocate_info,
    p_next: ?*const anyopaque = null,
    image: types.Image,
    buffer: types.Buffer,
};

pub const MemoryAllocateFlagsInfo = extern struct {
    s_type: types.StructureType = .memory_allocate_flags_info,
    p_next: ?*const anyopaque = null,
    flags: types.MemoryAllocateFlags,
    device_mask: u32,
};

pub const MemoryAllocateFlagBits = enum(u32) {
    device_mask = 0x00000001,
    device_address = 0x00000002,
    device_address_capture_replay = 0x00000004,
    device_address_capture_replay_within_group = 0x00000008,
    device_address_capture_replay_within_process = 0x00000010,
    _,
};

pub const MemoryAllocateFlags = types.Flags(MemoryAllocateFlagBits);

// ============================================================================
// External Memory Support
// ============================================================================

pub const PhysicalDeviceExternalBufferInfo = extern struct {
    s_type: types.StructureType = .physical_device_external_buffer_info,
    p_next: ?*const anyopaque = null,
    flags: types.BufferCreateFlags = .{},
    usage: types.BufferUsageFlags = .{},
    handle_type: types.ExternalMemoryHandleTypeFlags,
};

pub const ExternalBufferProperties = extern struct {
    s_type: types.StructureType = .external_buffer_properties,
    p_next: ?*anyopaque = null,
    external_memory_properties: types.ExternalMemoryProperties,
};

pub const PhysicalDeviceExternalFenceInfo = extern struct {
    s_type: types.StructureType = .physical_device_external_fence_info,
    p_next: ?*const anyopaque = null,
    handle_type: types.ExternalFenceHandleTypeFlags,
};

pub const ExternalFenceProperties = extern struct {
    s_type: types.StructureType = .external_fence_properties,
    p_next: ?*anyopaque = null,
    export_from_imported_handle_types: types.ExternalFenceHandleTypeFlags,
    compatible_handle_types: types.ExternalFenceHandleTypeFlags,
    external_fence_features: types.ExternalFenceFeatureFlags = .{},
};

pub const PhysicalDeviceExternalSemaphoreInfo = extern struct {
    s_type: types.StructureType = .physical_device_external_semaphore_info,
    p_next: ?*const anyopaque = null,
    handle_type: types.ExternalSemaphoreHandleTypeFlags,
};

pub const ExternalSemaphoreProperties = extern struct {
    s_type: types.StructureType = .external_semaphore_properties,
    p_next: ?*anyopaque = null,
    export_from_imported_handle_types: types.ExternalSemaphoreHandleTypeFlags,
    compatible_handle_types: types.ExternalSemaphoreHandleTypeFlags,
    external_semaphore_features: types.ExternalSemaphoreFeatureFlags = .{},
};

// ============================================================================
// Device Group Properties
// ============================================================================

pub const PhysicalDeviceGroupProperties = extern struct {
    s_type: types.StructureType = .physical_device_group_properties,
    p_next: ?*anyopaque = null,
    physical_device_count: u32,
    physical_devices: [constants.MAX_DEVICE_GROUP_SIZE]types.PhysicalDevice,
    subset_allocation: types.Bool32,
};

pub const PhysicalDeviceGroupProperties2 = extern struct {
    s_type: types.StructureType = .physical_device_group_properties_2,
    p_next: ?*anyopaque = null,
    physical_device_count: u32,
    physical_devices: [constants.MAX_DEVICE_GROUP_SIZE]types.PhysicalDevice,
    subset_allocation: types.Bool32,
    physical_device_group_count: u32,
};

// ============================================================================
// Extended Format and Image Properties
// ============================================================================

pub const FormatProperties2 = extern struct {
    s_type: types.StructureType = .format_properties_2,
    p_next: ?*anyopaque = null,
    format_properties: types.FormatProperties,
};

pub const ImageFormatProperties2 = extern struct {
    s_type: types.StructureType = .image_format_properties_2,
    p_next: ?*anyopaque = null,
    properties: types.ImageFormatProperties,
};

pub const QueueFamilyProperties2 = extern struct {
    s_type: types.StructureType = .queue_family_properties_2,
    p_next: ?*anyopaque = null,
    queue_family_properties: types.QueueFamilyProperties,
};

pub const PhysicalDeviceMemoryProperties2 = extern struct {
    s_type: types.StructureType = .physical_device_memory_properties_2,
    p_next: ?*anyopaque = null,
    memory_properties: types.PhysicalDeviceMemoryProperties,
};

pub const SparseImageFormatProperties2 = extern struct {
    s_type: types.StructureType = .sparse_image_format_properties_2,
    p_next: ?*anyopaque = null,
    properties: types.SparseImageFormatProperties,
};

pub const PhysicalDeviceImageFormatInfo2 = extern struct {
    s_type: types.StructureType = .physical_device_image_format_info_2,
    p_next: ?*const anyopaque = null,
    format: types.Format,
    type: types.ImageType,
    tiling: types.ImageTiling,
    usage: types.ImageUsageFlags,
    flags: types.ImageCreateFlags,
};

pub const PhysicalDeviceSparseImageFormatInfo2 = extern struct {
    s_type: types.StructureType = .physical_device_sparse_image_format_info_2,
    p_next: ?*const anyopaque = null,
    format: types.Format,
    type: types.ImageType,
    samples: types.SampleCountFlagBits,
    usage: types.ImageUsageFlags,
    tiling: types.ImageTiling,
    flags: types.ImageCreateFlags,
};

// ============================================================================
// Device Memory Requirements 2 Support
// ============================================================================

pub const MemoryRequirements2 = extern struct {
    s_type: types.StructureType = .memory_requirements_2,
    p_next: ?*anyopaque = null,
    memory_requirements: types.MemoryRequirements,
};

pub const ImageMemoryRequirementsInfo2 = extern struct {
    s_type: types.StructureType = .image_memory_requirements_info_2,
    p_next: ?*const anyopaque = null,
    image: types.Image,
};

pub const BufferMemoryRequirementsInfo2 = extern struct {
    s_type: types.StructureType = .buffer_memory_requirements_info_2,
    p_next: ?*const anyopaque = null,
    buffer: types.Buffer,
};

pub const ImageSparseMemoryRequirementsInfo2 = extern struct {
    s_type: types.StructureType = .image_sparse_memory_requirements_info_2,
    p_next: ?*const anyopaque = null,
    image: types.Image,
};

pub const ImageSubresource2 = extern struct {
    s_type: types.StructureType = .image_subresource_2,
    p_next: ?*anyopaque = null,
    image_subresource: types.ImageSubresource,
};

pub const ImageSubresourceLayout2 = extern struct {
    s_type: types.StructureType = .image_subresource_layout_2,
    p_next: ?*anyopaque = null,
    subresource: ImageSubresource2,
    offset: types.Offset3D,
    extent: types.Extent3D,
    row_pitch: types.DeviceSize,
    array_pitch: types.DeviceSize,
    depth_pitch: types.DeviceSize,
    size: types.DeviceSize,
};
