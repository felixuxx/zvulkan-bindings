//! Vulkan 1.1 Core Structures and Functions

const types = @import("types.zig");
const constants = @import("constants.zig");

// ============================================================================
// Structures
// ============================================================================

pub const PhysicalDeviceSubgroupProperties = extern struct {
    s_type: types.StructureType = .physical_device_subgroup_properties,
    p_next: ?*anyopaque = null,
    subgroup_size: u32,
    supported_stages: types.ShaderStageFlags,
    supported_operations: types.SubgroupFeatureFlags,
    quad_operations_in_all_stages: types.Bool32,
};

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

pub const PhysicalDevice16BitStorageFeatures = extern struct {
    s_type: types.StructureType = .physical_device_16bit_storage_features,
    p_next: ?*anyopaque = null,
    storage_buffer_16_bit_access: types.Bool32,
    uniform_and_storage_buffer_16_bit_access: types.Bool32,
    storage_push_constant_16_bit: types.Bool32,
    storage_input_output_16_bit: types.Bool32,
};

pub const MemoryDedicatedRequirements = extern struct {
    s_type: types.StructureType = .memory_dedicated_requirements,
    p_next: ?*anyopaque = null,
    prefers_dedicated_allocation: types.Bool32,
    requires_dedicated_allocation: types.Bool32,
};

pub const MemoryDedicatedAllocateInfo = extern struct {
    s_type: types.StructureType = .memory_dedicated_allocate_info,
    p_next: ?*const anyopaque = null,
    image: types.Image,
    buffer: types.Buffer,
};

pub const MemoryAllocateFlags = packed struct(u32) {
    device_mask_bit: bool = false,
    address_bit: bool = false, // Added in 1.2 but widely used with KHR_buffer_device_address
    device_address_capture_replay_bit: bool = false, // Added in 1.2
    _padding: u29 = 0,
};

pub const MemoryAllocateFlagsInfo = extern struct {
    s_type: types.StructureType = .memory_allocate_flags_info,
    p_next: ?*const anyopaque = null,
    flags: MemoryAllocateFlags,
    device_mask: u32,
};

pub const DeviceGroupDeviceCreateInfo = extern struct {
    s_type: types.StructureType = .device_group_device_create_info,
    p_next: ?*const anyopaque = null,
    physical_device_count: u32,
    p_physical_devices: ?[*]const types.PhysicalDevice,
};

pub const PhysicalDeviceGroupProperties = extern struct {
    s_type: types.StructureType = .physical_device_group_properties,
    p_next: ?*anyopaque = null,
    physical_device_count: u32,
    physical_devices: [constants.MAX_DEVICE_GROUP_SIZE]types.PhysicalDevice,
    subset_allocation: types.Bool32,
};

pub const BindBufferMemoryDeviceGroupInfo = extern struct {
    s_type: types.StructureType = .bind_buffer_memory_device_group_info,
    p_next: ?*const anyopaque = null,
    device_index_count: u32,
    p_device_indices: ?[*]const u32,
};

pub const BindImageMemoryDeviceGroupInfo = extern struct {
    s_type: types.StructureType = .bind_image_memory_device_group_info,
    p_next: ?*const anyopaque = null,
    device_index_count: u32,
    p_device_indices: ?[*]const u32,
    split_instance_bind_region_count: u32,
    p_split_instance_bind_regions: ?[*]const types.Rect2D,
};

pub const PhysicalDeviceFeatures2 = extern struct {
    s_type: types.StructureType = .physical_device_features_2,
    p_next: ?*anyopaque = null,
    features: extern struct {
        robust_buffer_access: types.Bool32,
        full_draw_index_uint32: types.Bool32,
        image_cube_array: types.Bool32,
        independent_blend: types.Bool32,
        geometry_shader: types.Bool32,
        tessellation_shader: types.Bool32,
        sample_rate_shading: types.Bool32,
        dual_src_blend: types.Bool32,
        logic_op: types.Bool32,
        multi_draw_indirect: types.Bool32,
        draw_indirect_first_instance: types.Bool32,
        depth_clamp: types.Bool32,
        depth_bias_clamp: types.Bool32,
        fill_mode_non_solid: types.Bool32,
        depth_bounds: types.Bool32,
        wide_lines: types.Bool32,
        large_points: types.Bool32,
        alpha_to_one: types.Bool32,
        multi_viewport: types.Bool32,
        sampler_anisotropy: types.Bool32,
        texture_compression_etc2: types.Bool32,
        texture_compression_astc_ldr: types.Bool32,
        texture_compression_bc: types.Bool32,
        occlusion_query_precise: types.Bool32,
        pipeline_statistics_query: types.Bool32,
        vertex_pipeline_stores_and_atomics: types.Bool32,
        fragment_stores_and_atomics: types.Bool32,
        shader_tessellation_and_geometry_point_size: types.Bool32,
        shader_image_gather_extended: types.Bool32,
        shader_storage_image_extended_formats: types.Bool32,
        shader_storage_image_multisample: types.Bool32,
        shader_storage_image_read_without_format: types.Bool32,
        shader_storage_image_write_without_format: types.Bool32,
        shader_uniform_buffer_array_dynamic_indexing: types.Bool32,
        shader_sampled_image_array_dynamic_indexing: types.Bool32,
        shader_storage_buffer_array_dynamic_indexing: types.Bool32,
        shader_storage_image_array_dynamic_indexing: types.Bool32,
        shader_clip_distance: types.Bool32,
        shader_cull_distance: types.Bool32,
        shader_float64: types.Bool32,
        shader_int64: types.Bool32,
        shader_int16: types.Bool32,
        shader_resource_residency: types.Bool32,
        shader_resource_min_lod: types.Bool32,
        sparse_binding: types.Bool32,
        sparse_residency_buffer: types.Bool32,
        sparse_residency_image_2d: types.Bool32,
        sparse_residency_image_3d: types.Bool32,
        sparse_residency2_samples: types.Bool32,
        sparse_residency4_samples: types.Bool32,
        sparse_residency8_samples: types.Bool32,
        sparse_residency16_samples: types.Bool32,
        sparse_residency_aliased: types.Bool32,
        variable_multisample_rate: types.Bool32,
        inherited_queries: types.Bool32,
    },
};

pub const PhysicalDeviceProperties2 = extern struct {
    s_type: types.StructureType = .physical_device_properties_2,
    p_next: ?*anyopaque = null,
    properties: extern struct {
        api_version: u32,
        driver_version: u32,
        vendor_id: u32,
        device_id: u32,
        device_type: types.PhysicalDeviceType,
        device_name: [constants.MAX_PHYSICAL_DEVICE_NAME_SIZE]u8,
        pipeline_cache_uuid: [constants.UUID_SIZE]u8,
        limits: extern struct {
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
        },
        sparse_properties: extern struct {
            residency_standard_2d_block_shape: types.Bool32,
            residency_standard_2d_multisample_block_shape: types.Bool32,
            residency_standard_3d_block_shape: types.Bool32,
            residency_aligned_mip_size: types.Bool32,
            residency_non_resident_strict: types.Bool32,
        },
    },
};

pub const FormatProperties2 = extern struct {
    s_type: types.StructureType = .format_properties_2,
    p_next: ?*const anyopaque = null,
    format_properties: extern struct {
        linear_tiling_features: types.FormatFeatureFlags,
        optimal_tiling_features: types.FormatFeatureFlags,
        buffer_features: types.FormatFeatureFlags,
    },
};

pub const ImageFormatProperties2 = extern struct {
    s_type: types.StructureType = .image_format_properties_2,
    p_next: ?*const anyopaque = null,
    image_format_properties: extern struct {
        max_extent: types.Extent3D,
        max_mip_levels: u32,
        max_array_layers: u32,
        sample_counts: types.SampleCountFlags,
        max_resource_size: types.DeviceSize,
    },
};

pub const QueueFamilyProperties2 = extern struct {
    s_type: types.StructureType = .queue_family_properties_2,
    p_next: ?*const anyopaque = null,
    queue_family_properties: extern struct {
        queue_flags: types.QueueFlags,
        queue_count: u32,
        timestamp_valid_bits: u32,
        min_image_transfer_granularity: types.Extent3D,
    },
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

pub const PhysicalDeviceMemoryProperties2 = extern struct {
    s_type: types.StructureType = .physical_device_memory_properties_2,
    p_next: ?*const anyopaque = null,
    memory_properties: extern struct {
        memory_type_count: u32,
        memory_types: [constants.MAX_MEMORY_TYPES]extern struct {
            property_flags: types.MemoryPropertyFlags,
            heap_index: u32,
        },
        memory_heap_count: u32,
        memory_heaps: [constants.MAX_MEMORY_HEAPS]extern struct {
            size: types.DeviceSize,
            flags: types.MemoryHeapFlags,
        },
    },
};

pub const SparseImageFormatProperties2 = extern struct {
    s_type: types.StructureType = .sparse_image_format_properties_2,
    p_next: ?*const anyopaque = null,
    properties: extern struct {
        aspect_mask: types.ImageAspectFlags,
        image_granularity: types.Extent3D,
        flags: types.SparseImageFormatFlags,
    },
};

pub const PhysicalDeviceSparseImageFormatInfo2 = extern struct {
    s_type: types.StructureType = .physical_device_sparse_image_format_info_2,
    p_next: ?*const anyopaque = null,
    format: types.Format,
    type: types.ImageType,
    samples: types.SampleCountFlagBits,
    usage: types.ImageUsageFlags,
    tiling: types.ImageTiling,
};

pub const PhysicalDeviceExternalBufferInfo = extern struct {
    s_type: types.StructureType = .physical_device_external_buffer_info,
    p_next: ?*const anyopaque = null,
    flags: types.BufferCreateFlags,
    usage: types.BufferUsageFlags,
    handle_type: types.ExternalMemoryHandleTypeFlagBits,
};

pub const ExternalBufferProperties = extern struct {
    s_type: types.StructureType = .external_buffer_properties,
    p_next: ?*anyopaque = null,
    external_memory_properties: types.ExternalMemoryProperties,
};

pub const PhysicalDeviceExternalFenceInfo = extern struct {
    s_type: types.StructureType = .physical_device_external_fence_info,
    p_next: ?*const anyopaque = null,
    handle_type: types.ExternalFenceHandleTypeFlagBits,
};

pub const ExternalFenceProperties = extern struct {
    s_type: types.StructureType = .external_fence_properties,
    p_next: ?*anyopaque = null,
    export_from_imported_handle_types: types.ExternalFenceHandleTypeFlags,
    compatible_handle_types: types.ExternalFenceHandleTypeFlags,
    external_fence_features: types.ExternalFenceFeatureFlags,
};

pub const PhysicalDeviceExternalSemaphoreInfo = extern struct {
    s_type: types.StructureType = .physical_device_external_semaphore_info,
    p_next: ?*const anyopaque = null,
    handle_type: types.ExternalSemaphoreHandleTypeFlagBits,
};

pub const ExternalSemaphoreProperties = extern struct {
    s_type: types.StructureType = .external_semaphore_properties,
    p_next: ?*anyopaque = null,
    export_from_imported_handle_types: types.ExternalSemaphoreHandleTypeFlags,
    compatible_handle_types: types.ExternalSemaphoreHandleTypeFlags,
    external_semaphore_features: types.ExternalSemaphoreFeatureFlags,
};
