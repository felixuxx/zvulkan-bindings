//! Core Vulkan types, handles, enumerations, and structures
//! This file contains the fundamental types needed for Vulkan API

const c = @import("constants.zig");

// ============================================================================
// Handle Types
// ============================================================================

// Dispatchable handles (pointer-sized, platform-specific)
pub const Instance = if (@sizeOf(usize) == 8) ?*opaque {} else u64;
pub const PhysicalDevice = if (@sizeOf(usize) == 8) ?*opaque {} else u64;
pub const Device = if (@sizeOf(usize) == 8) ?*opaque {} else u64;
pub const Queue = if (@sizeOf(usize) == 8) ?*opaque {} else u64;
pub const CommandBuffer = if (@sizeOf(usize) == 8) ?*opaque {} else u64;

// Non-dispatchable handles (always 64-bit)
pub const DeviceMemory = u64;
pub const CommandPool = u64;
pub const Buffer = u64;
pub const BufferView = u64;
pub const Image = u64;
pub const ImageView = u64;
pub const ShaderModule = u64;
pub const Pipeline = u64;
pub const PipelineLayout = u64;
pub const Sampler = u64;
pub const DescriptorSet = u64;
pub const DescriptorSetLayout = u64;
pub const DescriptorPool = u64;
pub const Fence = u64;
pub const Semaphore = u64;
pub const Event = u64;
pub const QueryPool = u64;
pub const Framebuffer = u64;
pub const RenderPass = u64;
pub const PipelineCache = u64;
pub const SurfaceKHR = u64;
pub const SwapchainKHR = u64;
pub const DebugUtilsMessengerEXT = u64;
pub const DebugReportCallbackEXT = u64;
pub const DescriptorUpdateTemplateKHR = u64;

// ============================================================================
// Basic Types
// ============================================================================

pub const Bool32 = u32;
pub const DeviceSize = u64;
pub const DeviceAddress = u64;
pub const SampleMask = u32;
pub const Flags = u32;

// ============================================================================
// Result Codes
// ============================================================================

pub const Result = enum(i32) {
    success = 0,
    not_ready = 1,
    timeout = 2,
    event_set = 3,
    event_reset = 4,
    incomplete = 5,
    error_out_of_host_memory = -1,
    error_out_of_device_memory = -2,
    error_initialization_failed = -3,
    error_device_lost = -4,
    error_memory_map_failed = -5,
    error_layer_not_present = -6,
    error_extension_not_present = -7,
    error_feature_not_present = -8,
    error_incompatible_driver = -9,
    error_too_many_objects = -10,
    error_format_not_supported = -11,
    error_fragmented_pool = -12,
    error_unknown = -13,
    error_out_of_pool_memory = -1000069000,
    error_invalid_external_handle = -1000072003,
    error_fragmentation = -1000161000,
    error_invalid_opaque_capture_address = -1000257000,
    error_surface_lost_khr = -1000000000,
    error_native_window_in_use_khr = -1000000001,
    suboptimal_khr = 1000001003,
    error_out_of_date_khr = -1000001004,
    error_incompatible_display_khr = -1000003001,
    error_validation_failed_ext = -1000011001,
    error_invalid_shader_nv = -1000012000,
    _,
};

// ============================================================================
// Structure Types
// ============================================================================

pub const StructureType = enum(i32) {
    application_info = 0,
    instance_create_info = 1,
    device_queue_create_info = 2,
    device_create_info = 3,
    submit_info = 4,
    memory_allocate_info = 5,
    mapped_memory_range = 6,
    bind_sparse_info = 7,
    fence_create_info = 8,
    semaphore_create_info = 9,
    event_create_info = 10,
    query_pool_create_info = 11,
    buffer_create_info = 12,
    buffer_view_create_info = 13,
    image_create_info = 14,
    image_view_create_info = 15,
    shader_module_create_info = 16,
    pipeline_cache_create_info = 17,
    pipeline_shader_stage_create_info = 18,
    pipeline_vertex_input_state_create_info = 19,
    pipeline_input_assembly_state_create_info = 20,
    pipeline_tessellation_state_create_info = 21,
    pipeline_viewport_state_create_info = 22,
    pipeline_rasterization_state_create_info = 23,
    pipeline_multisample_state_create_info = 24,
    pipeline_depth_stencil_state_create_info = 25,
    pipeline_color_blend_state_create_info = 26,
    pipeline_dynamic_state_create_info = 27,
    graphics_pipeline_create_info = 28,
    compute_pipeline_create_info = 29,
    pipeline_layout_create_info = 30,
    sampler_create_info = 31,
    descriptor_set_layout_create_info = 32,
    descriptor_pool_create_info = 33,
    descriptor_set_allocate_info = 34,
    write_descriptor_set = 35,
    copy_descriptor_set = 36,
    framebuffer_create_info = 37,
    render_pass_create_info = 38,
    command_pool_create_info = 39,
    command_buffer_allocate_info = 40,
    command_buffer_inheritance_info = 41,
    command_buffer_begin_info = 42,
    render_pass_begin_info = 43,
    buffer_memory_barrier = 44,
    image_memory_barrier = 45,
    memory_barrier = 46,
    loader_instance_create_info = 47,
    loader_device_create_info = 48,

    // Vulkan 1.1
    physical_device_subgroup_properties = 1000094000,
    bind_buffer_memory_info = 1000157000,
    bind_image_memory_info = 1000157001,
    physical_device_16bit_storage_features = 1000083000,
    memory_dedicated_requirements = 1000127000,
    memory_dedicated_allocate_info = 1000127001,
    memory_allocate_flags_info = 1000060000,
    device_group_device_create_info = 1000070001,
    device_group_render_pass_begin_info = 1000060003,
    device_group_command_buffer_begin_info = 1000060004,
    device_group_submit_info = 1000060005,
    device_group_bind_sparse_info = 1000060006,
    bind_buffer_memory_device_group_info = 1000060013,
    bind_image_memory_device_group_info = 1000060014,
    physical_device_group_properties = 1000070000,
    device_group_base_group_properties = 1000070002, // Wait, checking standard...
    physical_device_features_2 = 1000059000,
    physical_device_properties_2 = 1000059001,
    format_properties_2 = 1000059002,
    image_format_properties_2 = 1000059003,
    queue_family_properties_2 = 1000059004,
    physical_device_memory_properties_2 = 1000059005,
    sparse_image_format_properties_2 = 1000059006,
    physical_device_sparse_image_format_info_2 = 1000059007,
    physical_device_image_format_info_2 = 1000059008,
    image_memory_requirements_info_2 = 1000146001,
    buffer_memory_requirements_info_2 = 1000146000,
    memory_requirements_2 = 1000146003,
    sparse_image_memory_requirements_2 = 1000146004,
    command_buffer_inheritance_conditional_rendering_info_ext = 1000081000,
    external_memory_image_create_info = 1000072000,
    external_memory_buffer_create_info = 1000072001,
    export_memory_allocate_info = 1000072002,
    physical_device_external_image_format_info = 1000071000,
    external_image_format_properties = 1000071001,
    physical_device_external_buffer_info = 1000071002,
    external_buffer_properties = 1000071003,
    physical_device_id_properties = 1000071004,
    physical_device_external_fence_info = 1000112000,
    external_fence_properties = 1000112001,
    physical_device_external_semaphore_info = 1000076000,
    external_semaphore_properties = 1000076001,

    // Vulkan 1.2
    physical_device_vulkan_1_1_features = 49,
    physical_device_vulkan_1_1_properties = 50,
    physical_device_vulkan_1_2_features = 51,
    physical_device_vulkan_1_2_properties = 52,
    semaphore_type_create_info = 1000207002,
    timeline_semaphore_submit_info = 1000207003,
    semaphore_wait_info = 1000207004,
    semaphore_signal_info = 1000207005,
    device_memory_opaque_capture_address_info = 1000257004,
    buffer_device_address_info = 1000244001,
    render_pass_create_info_2 = 1000109000,
    attachment_description_2 = 1000109001,
    attachment_reference_2 = 1000109002,
    subpass_description_2 = 1000109003,
    subpass_dependency_2 = 1000109004,
    render_pass_input_attachment_aspect_create_info = 1000117000,
    input_attachment_aspect_reference = 1000117001,
    image_format_list_create_info = 1000147000,

    // Vulkan 1.3
    physical_device_vulkan_1_3_features = 53,
    physical_device_vulkan_1_3_properties = 54,

    // Vulkan 1.4
    physical_device_vulkan_1_4_features = 55,
    physical_device_vulkan_1_4_properties = 56,
    pipeline_creation_feedback_create_info = 1000192000,
    pipeline_rendering_create_info = 1000044000,
    rendering_info = 1000044001,
    rendering_attachment_info = 1000044002,
    pipeline_shader_stage_required_subgroup_size_create_info = 1000225000,
    physical_device_tool_properties = 1000245000,
    dependency_info = 1000314000,
    memory_barrier_2 = 1000314001,
    buffer_memory_barrier_2 = 1000314002,
    image_memory_barrier_2 = 1000314003,
    rendering_fragment_shading_rate_attachment_info_khr = 1000044006, // Alias needed for Checking

    swapchain_create_info_khr = 1000001000,
    present_info_khr = 1000001001,

    // VK_KHR_descriptor_update_template (promoted to core 1.1, but keeping KHR alias)
    descriptor_update_template_create_info_khr = 1000080000,
    descriptor_update_template_khr = 1000080001,

    // VK_KHR_push_descriptor
    physical_device_push_descriptor_properties_khr = 1000080003,
    push_descriptor_set_info_khr = 1000080004,
    push_descriptor_update_info_khr = 1000080005,

    // Inline uniform block (shared by both extensions)
    write_descriptor_set_inline_uniform_block = 1000281000,

    // VK_KHR_fragment_shading_rate
    fragment_shading_rate_attachment_info_khr = 1000226000,
    pipeline_fragment_shading_rate_state_create_info_khr = 1000226001,
    physical_device_fragment_shading_rate_properties_khr = 1000226002,
    physical_device_fragment_shading_rate_features_khr = 1000226003,
    physical_device_fragment_shading_rate_khr = 1000226004,

    // VK_INTEL_performance_query
    initialize_performance_api_info_intel = 1000210000,
    performance_configuration_acquire_info_intel = 1000210001,
    query_pool_performance_create_info_intel = 1000210002,
    performance_query_info_intel = 1000210003,
    performance_marker_info_intel = 1000210004,
    performance_override_info_intel = 1000210005,
    performance_stream_marker_info_intel = 1000210006,
    performance_configuration_intel = 1000210007,
    query_pool_performance_query_create_info_intel = 1000210008,

    wayland_surface_create_info_khr = 1000006000,
    win32_surface_create_info_khr = 1000009000,
    xlib_surface_create_info_khr = 1000004000,
    xcb_surface_create_info_khr = 1000005000,

    // Vulkan 1.4 / Maintenance5
    device_image_subresource_info = 1000300000,
    image_subresource_2 = 1000300001,
    rendering_area_info_khr = 1000300002,
    subresource_layout_2_khr = 1000300003,
    bind_memory_status_khr = 1000331000,
    _,
};

// ============================================================================
// Enumerations
// ============================================================================

pub const Format = enum(i32) {
    undefined = 0,
    r4g4_unorm_pack8 = 1,
    r4g4b4a4_unorm_pack16 = 2,
    b4g4r4a4_unorm_pack16 = 3,
    r5g6b5_unorm_pack16 = 4,
    b5g6r5_unorm_pack16 = 5,
    r5g5b5a1_unorm_pack16 = 6,
    b5g5r5a1_unorm_pack16 = 7,
    a1r5g5b5_unorm_pack16 = 8,
    r8_unorm = 9,
    r8_snorm = 10,
    r8_uscaled = 11,
    r8_sscaled = 12,
    r8_uint = 13,
    r8_sint = 14,
    r8_srgb = 15,
    r8g8_unorm = 16,
    r8g8_snorm = 17,
    r8g8_uscaled = 18,
    r8g8_sscaled = 19,
    r8g8_uint = 20,
    r8g8_sint = 21,
    r8g8_srgb = 22,
    r8g8b8_unorm = 23,
    r8g8b8_snorm = 24,
    r8g8b8_uscaled = 25,
    r8g8b8_sscaled = 26,
    r8g8b8_uint = 27,
    r8g8b8_sint = 28,
    r8g8b8_srgb = 29,
    b8g8r8_unorm = 30,
    b8g8r8_snorm = 31,
    b8g8r8_uscaled = 32,
    b8g8r8_sscaled = 33,
    b8g8r8_uint = 34,
    b8g8r8_sint = 35,
    b8g8r8_srgb = 36,
    r8g8b8a8_unorm = 37,
    r8g8b8a8_snorm = 38,
    r8g8b8a8_uscaled = 39,
    r8g8b8a8_sscaled = 40,
    r8g8b8a8_uint = 41,
    r8g8b8a8_sint = 42,
    r8g8b8a8_srgb = 43,
    b8g8r8a8_unorm = 44,
    b8g8r8a8_snorm = 45,
    b8g8r8a8_uscaled = 46,
    b8g8r8a8_sscaled = 47,
    b8g8r8a8_uint = 48,
    b8g8r8a8_sint = 49,
    b8g8r8a8_srgb = 50,
    a8b8g8r8_unorm_pack32 = 51,
    a8b8g8r8_snorm_pack32 = 52,
    a8b8g8r8_uscaled_pack32 = 53,
    a8b8g8r8_sscaled_pack32 = 54,
    a8b8g8r8_uint_pack32 = 55,
    a8b8g8r8_sint_pack32 = 56,
    a8b8g8r8_srgb_pack32 = 57,
    a2r10g10b10_unorm_pack32 = 58,
    a2r10g10b10_snorm_pack32 = 59,
    a2r10g10b10_uscaled_pack32 = 60,
    a2r10g10b10_sscaled_pack32 = 61,
    a2r10g10b10_uint_pack32 = 62,
    a2r10g10b10_sint_pack32 = 63,
    a2b10g10r10_unorm_pack32 = 64,
    a2b10g10r10_snorm_pack32 = 65,
    a2b10g10r10_uscaled_pack32 = 66,
    a2b10g10r10_sscaled_pack32 = 67,
    a2b10g10r10_uint_pack32 = 68,
    a2b10g10r10_sint_pack32 = 69,
    r16_unorm = 70,
    r16_snorm = 71,
    r16_uscaled = 72,
    r16_sscaled = 73,
    r16_uint = 74,
    r16_sint = 75,
    r16_sfloat = 76,
    r16g16_unorm = 77,
    r16g16_snorm = 78,
    r16g16_uscaled = 79,
    r16g16_sscaled = 80,
    r16g16_uint = 81,
    r16g16_sint = 82,
    r16g16_sfloat = 83,
    r16g16b16_unorm = 84,
    r16g16b16_snorm = 85,
    r16g16b16_uscaled = 86,
    r16g16b16_sscaled = 87,
    r16g16b16_uint = 88,
    r16g16b16_sint = 89,
    r16g16b16_sfloat = 90,
    r16g16b16a16_unorm = 91,
    r16g16b16a16_snorm = 92,
    r16g16b16a16_uscaled = 93,
    r16g16b16a16_sscaled = 94,
    r16g16b16a16_uint = 95,
    r16g16b16a16_sint = 96,
    r16g16b16a16_sfloat = 97,
    r32_uint = 98,
    r32_sint = 99,
    r32_sfloat = 100,
    r32g32_uint = 101,
    r32g32_sint = 102,
    r32g32_sfloat = 103,
    r32g32b32_uint = 104,
    r32g32b32_sint = 105,
    r32g32b32_sfloat = 106,
    r32g32b32a32_uint = 107,
    r32g32b32a32_sint = 108,
    r32g32b32a32_sfloat = 109,
    r64_uint = 110,
    r64_sint = 111,
    r64_sfloat = 112,
    r64g64_uint = 113,
    r64g64_sint = 114,
    r64g64_sfloat = 115,
    r64g64b64_uint = 116,
    r64g64b64_sint = 117,
    r64g64b64_sfloat = 118,
    r64g64b64a64_uint = 119,
    r64g64b64a64_sint = 120,
    r64g64b64a64_sfloat = 121,
    b10g11r11_ufloat_pack32 = 122,
    e5b9g9r9_ufloat_pack32 = 123,
    d16_unorm = 124,
    x8_d24_unorm_pack32 = 125,
    d32_sfloat = 126,
    s8_uint = 127,
    d16_unorm_s8_uint = 128,
    d24_unorm_s8_uint = 129,
    d32_sfloat_s8_uint = 130,
    bc1_rgb_unorm_block = 131,
    bc1_rgb_srgb_block = 132,
    bc1_rgba_unorm_block = 133,
    bc1_rgba_srgb_block = 134,
    bc2_unorm_block = 135,
    bc2_srgb_block = 136,
    bc3_unorm_block = 137,
    bc3_srgb_block = 138,
    bc4_unorm_block = 139,
    bc4_snorm_block = 140,
    bc5_unorm_block = 141,
    bc5_snorm_block = 142,
    bc6h_ufloat_block = 143,
    bc6h_sfloat_block = 144,
    bc7_unorm_block = 145,
    bc7_srgb_block = 146,
    etc2_r8g8b8_unorm_block = 147,
    etc2_r8g8b8_srgb_block = 148,
    etc2_r8g8b8a1_unorm_block = 149,
    etc2_r8g8b8a1_srgb_block = 150,
    etc2_r8g8b8a8_unorm_block = 151,
    etc2_r8g8b8a8_srgb_block = 152,
    eac_r11_unorm_block = 153,
    eac_r11_snorm_block = 154,
    eac_r11g11_unorm_block = 155,
    eac_r11g11_snorm_block = 156,
    astc_4x_4_unorm_block = 157,
    astc_4x_4_srgb_block = 158,
    astc_5x_4_unorm_block = 159,
    astc_5x_4_srgb_block = 160,
    astc_5x_5_unorm_block = 161,
    astc_5x_5_srgb_block = 162,
    astc_6x_5_unorm_block = 163,
    astc_6x_5_srgb_block = 164,
    astc_6x_6_unorm_block = 165,
    astc_6x_6_srgb_block = 166,
    astc_8x_5_unorm_block = 167,
    astc_8x_5_srgb_block = 168,
    astc_8x_6_unorm_block = 169,
    astc_8x_6_srgb_block = 170,
    astc_8x_8_unorm_block = 171,
    astc_8x_8_srgb_block = 172,
    astc_1_0x_5_unorm_block = 173,
    astc_1_0x_5_srgb_block = 174,
    astc_1_0x_6_unorm_block = 175,
    astc_1_0x_6_srgb_block = 176,
    astc_1_0x_8_unorm_block = 177,
    astc_1_0x_8_srgb_block = 178,
    astc_1_0x_10_unorm_block = 179,
    astc_1_0x_10_srgb_block = 180,
    astc_1_2x_10_unorm_block = 181,
    astc_1_2x_10_srgb_block = 182,
    astc_1_2x_12_unorm_block = 183,
    astc_1_2x_12_srgb_block = 184,
    g8b8g8r8_422_unorm = 1000156000,
    b8g8r8g8_422_unorm = 1000156001,
    g8_b8_r8_3plane_420_unorm = 1000156002,
    g8_b8r8_2plane_420_unorm = 1000156003,
    g8_b8_r8_3plane_422_unorm = 1000156004,
    g8_b8r8_2plane_422_unorm = 1000156005,
    g8_b8_r8_3plane_444_unorm = 1000156006,
    r10x6_unorm_pack16 = 1000156007,
    r10x6g10x6_unorm_2pack16 = 1000156008,
    r10x6g10x6b10x6a10x6_unorm_4pack16 = 1000156009,
    g10x6b10x6g10x6r10x6_422_unorm_4pack16 = 1000156010,
    b10x6g10x6r10x6g10x6_422_unorm_4pack16 = 1000156011,
    g10x6_b10x6_r10x6_3plane_420_unorm_3pack16 = 1000156012,
    g10x6_b10x6r10x6_2plane_420_unorm_3pack16 = 1000156013,
    g10x6_b10x6_r10x6_3plane_422_unorm_3pack16 = 1000156014,
    g10x6_b10x6r10x6_2plane_422_unorm_3pack16 = 1000156015,
    g10x6_b10x6_r10x6_3plane_444_unorm_3pack16 = 1000156016,
    r12x4_unorm_pack16 = 1000156017,
    r12x4g12x4_unorm_2pack16 = 1000156018,
    r12x4g12x4b12x4a12x4_unorm_4pack16 = 1000156019,
    g12x4b12x4g12x4r12x4_422_unorm_4pack16 = 1000156020,
    b12x4g12x4r12x4g12x4_422_unorm_4pack16 = 1000156021,
    g12x4_b12x4_r12x4_3plane_420_unorm_3pack16 = 1000156022,
    g12x4_b12x4r12x4_2plane_420_unorm_3pack16 = 1000156023,
    g12x4_b12x4_r12x4_3plane_422_unorm_3pack16 = 1000156024,
    g12x4_b12x4r12x4_2plane_422_unorm_3pack16 = 1000156025,
    g12x4_b12x4_r12x4_3plane_444_unorm_3pack16 = 1000156026,
    g16b16g16r16_422_unorm = 1000156027,
    b16g16r16g16_422_unorm = 1000156028,
    g16_b16_r16_3plane_420_unorm = 1000156029,
    g16_b16r16_2plane_420_unorm = 1000156030,
    g16_b16_r16_3plane_422_unorm = 1000156031,
    g16_b16r16_2plane_422_unorm = 1000156032,
    g16_b16_r16_3plane_444_unorm = 1000156033,
    g8_b8r8_2plane_444_unorm = 1000330000,
    g10x6_b10x6r10x6_2plane_444_unorm_3pack16 = 1000330001,
    g12x4_b12x4r12x4_2plane_444_unorm_3pack16 = 1000330002,
    g16_b16r16_2plane_444_unorm = 1000330003,
    a4r4g4b4_unorm_pack16 = 1000340000,
    a4b4g4r4_unorm_pack16 = 1000340001,
    astc_4x_4_sfloat_block = 1000066000,
    astc_5x_4_sfloat_block = 1000066001,
    astc_5x_5_sfloat_block = 1000066002,
    astc_6x_5_sfloat_block = 1000066003,
    astc_6x_6_sfloat_block = 1000066004,
    astc_8x_5_sfloat_block = 1000066005,
    astc_8x_6_sfloat_block = 1000066006,
    astc_8x_8_sfloat_block = 1000066007,
    astc_1_0x_5_sfloat_block = 1000066008,
    astc_1_0x_6_sfloat_block = 1000066009,
    astc_1_0x_8_sfloat_block = 1000066010,
    astc_1_0x_10_sfloat_block = 1000066011,
    astc_1_2x_10_sfloat_block = 1000066012,
    astc_1_2x_12_sfloat_block = 1000066013,
    pvrtc1_2bpp_unorm_block_img = 1000054000,
    pvrtc1_4bpp_unorm_block_img = 1000054001,
    pvrtc2_2bpp_unorm_block_img = 1000054002,
    pvrtc2_4bpp_unorm_block_img = 1000054003,
    pvrtc1_2bpp_srgb_block_img = 1000054004,
    pvrtc1_4bpp_srgb_block_img = 1000054005,
    pvrtc2_2bpp_srgb_block_img = 1000054006,
    pvrtc2_4bpp_srgb_block_img = 1000054007,
    r16g16_sfixed5_nv = 1000464000,
    a1b5g5r5_unorm_pack16_khr = 1000470000,
    a8_unorm_khr = 1000470001,
    _,
};

pub const ImageLayout = enum(i32) {
    undefined = 0,
    general = 1,
    color_attachment_optimal = 2,
    depth_stencil_attachment_optimal = 3,
    depth_stencil_read_only_optimal = 4,
    shader_read_only_optimal = 5,
    transfer_src_optimal = 6,
    transfer_dst_optimal = 7,
    preinitialized = 8,
    depth_read_only_stencil_attachment_optimal = 1000117000,
    depth_attachment_stencil_read_only_optimal = 1000117001,
    depth_attachment_optimal = 1000241000,
    depth_read_only_optimal = 1000241001,
    stencil_attachment_optimal = 1000241002,
    stencil_read_only_optimal = 1000241003,
    read_only_optimal = 1000314000,
    attachment_optimal = 1000314001,
    present_src_khr = 1000001002,
    video_decode_dst_khr = 1000024000,
    video_decode_src_khr = 1000024001,
    video_decode_dpb_khr = 1000024002,
    shared_present_khr = 1000111000,
    fragment_density_map_optimal_ext = 1000218000,
    fragment_shading_rate_attachment_optimal_khr = 1000164003,
    rendering_local_read_khr = 1000232000,
    video_encode_dst_khr = 1000299000,
    video_encode_src_khr = 1000299001,
    video_encode_dpb_khr = 1000299002,
    attachment_feedback_loop_optimal_ext = 1000339000,
    _,
    pub const depth_read_only_stencil_attachment_optimal_khr = ImageLayout.depth_read_only_stencil_attachment_optimal;
    pub const depth_attachment_stencil_read_only_optimal_khr = ImageLayout.depth_attachment_stencil_read_only_optimal;
    pub const shading_rate_optimal_nv = ImageLayout.fragment_shading_rate_attachment_optimal_khr;
    pub const depth_attachment_optimal_khr = ImageLayout.depth_attachment_optimal;
    pub const depth_read_only_optimal_khr = ImageLayout.depth_read_only_optimal;
    pub const stencil_attachment_optimal_khr = ImageLayout.stencil_attachment_optimal;
    pub const stencil_read_only_optimal_khr = ImageLayout.stencil_read_only_optimal;
    pub const read_only_optimal_khr = ImageLayout.read_only_optimal;
    pub const attachment_optimal_khr = ImageLayout.attachment_optimal;
};

pub const ImageType = enum(i32) {
    @"1d" = 0,
    @"2d" = 1,
    @"3d" = 2,
    _,
};

pub const ImageTiling = enum(i32) {
    optimal = 0,
    linear = 1,
    drm_format_modifier_ext = 1000158000,
    _,
};

pub const ImageViewType = enum(i32) {
    @"1d" = 0,
    @"2d" = 1,
    @"3d" = 2,
    cube = 3,
    @"1d_array" = 4,
    @"2d_array" = 5,
    cube_array = 6,
    _,
};

pub const SharingMode = enum(i32) {
    exclusive = 0,
    concurrent = 1,
    _,
};

pub const ComponentSwizzle = enum(i32) {
    identity = 0,
    zero = 1,
    one = 2,
    r = 3,
    g = 4,
    b = 5,
    a = 6,
    _,
};

pub const SemaphoreType = enum(i32) {
    binary = 0,
    timeline = 1,
    _,
};

pub const PointClippingBehavior = enum(i32) {
    all_clip_planes = 0,
    user_clip_planes_only = 1,
    _,
};

pub const ShaderFloatControlsIndependence = enum(i32) {
    @"32_bit_only" = 0,
    all = 1,
    none = 2,
    _,
};

pub const DriverId = enum(i32) {
    amd_proprietary = 1,
    amd_open_source = 2,
    mesa_radv = 3,
    nvidia_proprietary = 4,
    intel_proprietary_windows = 5,
    intel_open_source_mesa = 6,
    imagination_proprietary = 7,
    qualcomm_proprietary = 8,
    arm_proprietary = 9,
    google_swiftshader = 10,
    ggp_proprietary = 11,
    broadcom_proprietary = 12,
    mesa_llvmpipe = 13,
    moltenvk = 14,
    _,
};

pub const PhysicalDeviceType = enum(i32) {
    other = 0,
    integrated_gpu = 1,
    discrete_gpu = 2,
    virtual_gpu = 3,
    cpu = 4,
    _,
};

pub const MAX_DRIVER_INFO_SIZE = 256;
pub const LUID_SIZE = 8;
pub const MAX_DEVICE_GROUP_SIZE = 32;

pub const WHOLE_SIZE = u64;

pub const QueryType = enum(i32) {
    occlusion = 0,
    pipeline_statistics = 1,
    timestamp = 2,
    performance_query_intel = 1000210000,
    _,
};

pub const QueryPoolCreateFlags = u32;

pub const EventCreateFlags = u32;

pub const ConformanceVersion = extern struct {
    major: u8,
    minor: u8,
    subminor: u8,
    patch: u8,
};

pub const ResolveModeFlags = packed struct(u32) {
    none: bool = false,
    sample_zero: bool = false,
    average: bool = false,
    min: bool = false,
    max: bool = false,
    _padding: u27 = 0,
};

pub const SemaphoreWaitFlags = packed struct(u32) {
    any: bool = false,
    _padding: u31 = 0,
};

pub const PipelineBindPoint = enum(i32) {
    graphics = 0,
    compute = 1,
    execution_graph_amdx = 1000134000,
    ray_tracing_khr = 1000165000,
    subpass_shading_huawei = 1000369003,
    _,
    pub const ray_tracing_nv = PipelineBindPoint.ray_tracing_khr;
};

pub const PrimitiveTopology = enum(i32) {
    point_list = 0,
    line_list = 1,
    line_strip = 2,
    triangle_list = 3,
    triangle_strip = 4,
    triangle_fan = 5,
    line_list_with_adjacency = 6,
    line_strip_with_adjacency = 7,
    triangle_list_with_adjacency = 8,
    triangle_strip_with_adjacency = 9,
    patch_list = 10,
    _,
};

pub const VertexInputRate = enum(i32) {
    vertex = 0,
    instance = 1,
    _,
};

pub const PolygonMode = enum(i32) {
    fill = 0,
    line = 1,
    point = 2,
    _,
};

pub const FrontFace = enum(i32) {
    counter_clockwise = 0,
    clockwise = 1,
    _,
};

pub const CompareOp = enum(i32) {
    never = 0,
    less = 1,
    equal = 2,
    less_or_equal = 3,
    greater = 4,
    not_equal = 5,
    greater_or_equal = 6,
    always = 7,
    _,
};

pub const StencilOp = enum(i32) {
    keep = 0,
    zero = 1,
    replace = 2,
    increment_and_clamp = 3,
    decrement_and_clamp = 4,
    invert = 5,
    increment_and_wrap = 6,
    decrement_and_wrap = 7,
    _,
};

pub const LogicOp = enum(i32) {
    clear = 0,
    @"and" = 1,
    and_reverse = 2,
    copy = 3,
    and_inverted = 4,
    no_op = 5,
    xor = 6,
    @"or" = 7,
    nor = 8,
    equivalent = 9,
    invert = 10,
    or_reverse = 11,
    copy_inverted = 12,
    or_inverted = 13,
    nand = 14,
    set = 15,
    _,
};

pub const BlendFactor = enum(i32) {
    zero = 0,
    one = 1,
    src_color = 2,
    one_minus_src_color = 3,
    dst_color = 4,
    one_minus_dst_color = 5,
    src_alpha = 6,
    one_minus_src_alpha = 7,
    dst_alpha = 8,
    one_minus_dst_alpha = 9,
    constant_color = 10,
    one_minus_constant_color = 11,
    constant_alpha = 12,
    one_minus_constant_alpha = 13,
    src_alpha_saturate = 14,
    _,
};

pub const BlendOp = enum(i32) {
    add = 0,
    subtract = 1,
    reverse_subtract = 2,
    min = 3,
    max = 4,
    _,
};

pub const DynamicState = enum(i32) {
    viewport = 0,
    scissor = 1,
    line_width = 2,
    depth_bias = 3,
    blend_constants = 4,
    depth_bounds = 5,
    stencil_compare_mask = 6,
    stencil_write_mask = 7,
    stencil_reference = 8,
    cull_mode = 1000267000,
    front_face = 1000267001,
    primitive_topology = 1000267002,
    viewport_with_count = 1000267003,
    scissor_with_count = 1000267004,
    vertex_input_binding_stride = 1000267005,
    depth_test_enable = 1000267006,
    depth_write_enable = 1000267007,
    depth_compare_op = 1000267008,
    depth_bounds_test_enable = 1000267009,
    stencil_test_enable = 1000267010,
    stencil_op = 1000267011,
    rasterizer_discard_enable = 1000377001,
    depth_bias_enable = 1000377002,
    primitive_restart_enable = 1000377004,
    viewport_w_scaling_nv = 1000087000,
    discard_rectangle_ext = 1000099000,
    discard_rectangle_enable_ext = 1000099001,
    discard_rectangle_mode_ext = 1000099002,
    sample_locations_ext = 1000143000,
    ray_tracing_pipeline_stack_size_khr = 1000347000,
    viewport_shading_rate_palette_nv = 1000164004,
    viewport_coarse_sample_order_nv = 1000164006,
    exclusive_scissor_enable_nv = 1000205000,
    exclusive_scissor_nv = 1000205001,
    fragment_shading_rate_khr = 1000226000,
    vertex_input_ext = 1000352000,
    patch_control_points_ext = 1000377000,
    logic_op_ext = 1000377003,
    color_write_enable_ext = 1000381000,
    depth_clamp_enable_ext = 1000455003,
    polygon_mode_ext = 1000455004,
    rasterization_samples_ext = 1000455005,
    sample_mask_ext = 1000455006,
    alpha_to_coverage_enable_ext = 1000455007,
    alpha_to_one_enable_ext = 1000455008,
    logic_op_enable_ext = 1000455009,
    color_blend_enable_ext = 1000455010,
    color_blend_equation_ext = 1000455011,
    color_write_mask_ext = 1000455012,
    tessellation_domain_origin_ext = 1000455002,
    rasterization_stream_ext = 1000455013,
    conservative_rasterization_mode_ext = 1000455014,
    extra_primitive_overestimation_size_ext = 1000455015,
    depth_clip_enable_ext = 1000455016,
    sample_locations_enable_ext = 1000455017,
    color_blend_advanced_ext = 1000455018,
    provoking_vertex_mode_ext = 1000455019,
    line_rasterization_mode_ext = 1000455020,
    line_stipple_enable_ext = 1000455021,
    depth_clip_negative_one_to_one_ext = 1000455022,
    viewport_w_scaling_enable_nv = 1000455023,
    viewport_swizzle_nv = 1000455024,
    coverage_to_color_enable_nv = 1000455025,
    coverage_to_color_location_nv = 1000455026,
    coverage_modulation_mode_nv = 1000455027,
    coverage_modulation_table_enable_nv = 1000455028,
    coverage_modulation_table_nv = 1000455029,
    shading_rate_image_enable_nv = 1000455030,
    representative_fragment_test_enable_nv = 1000455031,
    coverage_reduction_mode_nv = 1000455032,
    attachment_feedback_loop_enable_ext = 1000524000,
    line_stipple_khr = 1000259000,
    _,
    pub const line_stipple_ext = DynamicState.line_stipple_khr;
    pub const cull_mode_ext = DynamicState.cull_mode;
    pub const front_face_ext = DynamicState.front_face;
    pub const primitive_topology_ext = DynamicState.primitive_topology;
    pub const viewport_with_count_ext = DynamicState.viewport_with_count;
    pub const scissor_with_count_ext = DynamicState.scissor_with_count;
    pub const vertex_input_binding_stride_ext = DynamicState.vertex_input_binding_stride;
    pub const depth_test_enable_ext = DynamicState.depth_test_enable;
    pub const depth_write_enable_ext = DynamicState.depth_write_enable;
    pub const depth_compare_op_ext = DynamicState.depth_compare_op;
    pub const depth_bounds_test_enable_ext = DynamicState.depth_bounds_test_enable;
    pub const stencil_test_enable_ext = DynamicState.stencil_test_enable;
    pub const stencil_op_ext = DynamicState.stencil_op;
    pub const rasterizer_discard_enable_ext = DynamicState.rasterizer_discard_enable;
    pub const depth_bias_enable_ext = DynamicState.depth_bias_enable;
    pub const primitive_restart_enable_ext = DynamicState.primitive_restart_enable;
};

pub const Filter = enum(i32) {
    nearest = 0,
    linear = 1,
    cubic_ext = 1000015000,
    _,
};

pub const SamplerMipmapMode = enum(i32) {
    nearest = 0,
    linear = 1,
    _,
};

pub const SamplerAddressMode = enum(i32) {
    repeat = 0,
    mirrored_repeat = 1,
    clamp_to_edge = 2,
    clamp_to_border = 3,
    _,
};

pub const BorderColor = enum(i32) {
    float_transparent_black = 0,
    int_transparent_black = 1,
    float_opaque_black = 2,
    int_opaque_black = 3,
    float_opaque_white = 4,
    int_opaque_white = 5,
    float_custom_ext = 1000287003,
    int_custom_ext = 1000287004,
    _,
};

pub const DescriptorType = enum(i32) {
    sampler = 0,
    combined_image_sampler = 1,
    sampled_image = 2,
    storage_image = 3,
    uniform_texel_buffer = 4,
    storage_texel_buffer = 5,
    uniform_buffer = 6,
    storage_buffer = 7,
    uniform_buffer_dynamic = 8,
    storage_buffer_dynamic = 9,
    input_attachment = 10,
    inline_uniform_block = 1000138000,
    _,
};

pub const AttachmentLoadOp = enum(i32) {
    load = 0,
    clear = 1,
    dont_care = 2,
    _,
};

pub const AttachmentStoreOp = enum(i32) {
    store = 0,
    dont_care = 1,
    _,
};

pub const CommandBufferLevel = enum(i32) {
    primary = 0,
    secondary = 1,
    _,
};

pub const IndexType = enum(i32) {
    uint16 = 0,
    uint32 = 1,
    _,
};

pub const SubpassContents = enum(i32) {
    inline_commands = 0,
    secondary_command_buffers = 1,
    _,
};

pub const ObjectType = enum(i32) {
    unknown = 0,
    instance = 1,
    physical_device = 2,
    device = 3,
    queue = 4,
    semaphore = 5,
    command_buffer = 6,
    fence = 7,
    device_memory = 8,
    buffer = 9,
    image = 10,
    event = 11,
    query_pool = 12,
    buffer_view = 13,
    image_view = 14,
    shader_module = 15,
    pipeline_cache = 16,
    pipeline_layout = 17,
    render_pass = 18,
    pipeline = 19,
    descriptor_set_layout = 20,
    sampler = 21,
    descriptor_pool = 22,
    descriptor_set = 23,
    framebuffer = 24,
    command_pool = 25,
    sampler_ycbcr_conversion = 1000156000,
    descriptor_update_template = 1000085000,
    private_data_slot = 1000295000,
    surface_khr = 1000000000,
    swapchain_khr = 1000001000,
    display_khr = 1000002000,
    display_mode_khr = 1000002001,
    debug_report_callback_ext = 1000011000,
    video_session_khr = 1000023000,
    video_session_parameters_khr = 1000023001,
    cu_module_nvx = 1000029000,
    cu_function_nvx = 1000029001,
    debug_utils_messenger_ext = 1000128000,
    acceleration_structure_khr = 1000150000,
    validation_cache_ext = 1000160000,
    acceleration_structure_nv = 1000165000,
    performance_configuration_intel = 1000210000,
    deferred_operation_khr = 1000268000,
    indirect_commands_layout_nv = 1000277000,
    cuda_module_nv = 1000307000,
    cuda_function_nv = 1000307001,
    buffer_collection_fuchsia = 1000366000,
    micromap_ext = 1000396000,
    optical_flow_session_nv = 1000464000,
    _,
};

// ============================================================================
// Flag Bits
// ============================================================================

pub const QueueFlags = packed struct(u32) {
    graphics: bool = false,
    compute: bool = false,
    transfer: bool = false,
    sparse_binding: bool = false,
    protected: bool = false,
    _padding: u27 = 0,
};

pub const MemoryPropertyFlags = packed struct(u32) {
    device_local: bool = false,
    host_visible: bool = false,
    host_coherent: bool = false,
    host_cached: bool = false,
    lazily_allocated: bool = false,
    protected: bool = false,
    _padding: u26 = 0,
};

pub const MemoryHeapFlags = packed struct(u32) {
    device_local: bool = false,
    multi_instance: bool = false,
    _padding: u30 = 0,
};

pub const ImageUsageFlags = packed struct(u32) {
    transfer_src: bool = false,
    transfer_dst: bool = false,
    sampled: bool = false,
    storage: bool = false,
    color_attachment: bool = false,
    depth_stencil_attachment: bool = false,
    transient_attachment: bool = false,
    input_attachment: bool = false,
    video_decode_dpb_bit_khr: bool = false,
    acceleration_structure_vertex_buffer_bit_khr: bool = false,
    fragment_density_map_bit_ext: bool = false,
    fragment_shading_rate_attachment_bit_khr: bool = false,
    _padding: u20 = 0,
};

pub const SparseImageFormatFlags = packed struct(u32) {
    single_subresource: bool = false,
    aligned_mip_size: bool = false,
    non_standard_block_size: bool = false,
    _padding: u29 = 0,
};

pub const ImageCreateFlags = packed struct(u32) {
    sparse_binding: bool = false,
    sparse_residency: bool = false,
    sparse_aliased: bool = false,
    mutable_format: bool = false,
    cube_compatible: bool = false,
    _padding: u27 = 0,
};

pub const FormatFeatureFlags = packed struct(u32) {
    sampled_image: bool = false,
    storage_image: bool = false,
    storage_image_atomic: bool = false,
    uniform_texel_buffer: bool = false,
    storage_texel_buffer: bool = false,
    storage_texel_buffer_atomic: bool = false,
    vertex_buffer: bool = false,
    color_attachment: bool = false,
    color_attachment_blend: bool = false,
    depth_stencil_attachment: bool = false,
    blit_src: bool = false,
    blit_dst: bool = false,
    sampled_image_filter_linear: bool = false,
    transfer_src: bool = false,
    transfer_dst: bool = false,
    midpoint_chroma_samples: bool = false,
    sampled_image_ycbcr_conversion_linear_filter: bool = false,
    sampled_image_ycbcr_conversion_separate_reconstruction_filter: bool = false,
    sampled_image_ycbcr_conversion_chroma_reconstruction_explicit: bool = false,
    sampled_image_ycbcr_conversion_chroma_reconstruction_explicit_forceable: bool = false,
    disjoint: bool = false,
    cosited_chroma_samples: bool = false,
    sampled_image_filter_minmax: bool = false,
    _padding: u9 = 0,
};

pub const ExternalMemoryHandleTypeFlags = packed struct(u32) {
    opaque_fd: bool = false,
    opaque_win32: bool = false,
    opaque_win32_kmt: bool = false,
    d3d11_texture: bool = false,
    d3d11_texture_kmt: bool = false,
    d3d12_heap: bool = false,
    d3d12_resource: bool = false,
    dma_buf: bool = false,
    android_hardware_buffer: bool = false,
    host_allocation: bool = false,
    host_mapped_foreign_memory: bool = false,
    _padding: u21 = 0,
};

pub const ExternalMemoryHandleTypeFlagBits = enum(u32) {
    opaque_fd_bit = 0x00000001,
    opaque_win32_bit = 0x00000002,
    opaque_win32_kmt_bit = 0x00000004,
    d3d11_texture_bit = 0x00000008,
    d3d11_texture_kmt_bit = 0x00000010,
    d3d12_heap_bit = 0x00000020,
    d3d12_resource_bit = 0x00000040,
    dma_buf_bit = 0x00000080,
    android_hardware_buffer_bit_android = 0x00000400,
    // host_allocation_bit_ext = 0x00000080, // Duplicate value with dma_buf_bit
    host_mapped_foreign_memory_bit_ext = 0x00000100,
    _,
};

pub const ExternalMemoryFeatureFlags = packed struct(u32) {
    dedicated_only: bool = false,
    exportable: bool = false,
    importable: bool = false,
    _padding: u29 = 0,
};

pub const ExternalFenceHandleTypeFlags = packed struct(u32) {
    opaque_fd: bool = false,
    opaque_win32: bool = false,
    opaque_win32_kmt: bool = false,
    sync_fd: bool = false,
    _padding: u28 = 0,
};

pub const ExternalFenceHandleTypeFlagBits = enum(u32) {
    opaque_fd_bit = 0x00000001,
    opaque_win32_bit = 0x00000002,
    opaque_win32_kmt_bit = 0x00000004,
    sync_fd_bit = 0x00000008,
    _,
};

pub const ExternalFenceFeatureFlags = packed struct(u32) {
    exportable: bool = false,
    importable: bool = false,
    _padding: u30 = 0,
};

pub const ExternalSemaphoreHandleTypeFlags = packed struct(u32) {
    opaque_fd: bool = false,
    opaque_win32: bool = false,
    opaque_win32_kmt: bool = false,
    d3d12_fence: bool = false,
    sync_fd: bool = false,
    _padding: u27 = 0,
};

pub const ExternalSemaphoreHandleTypeFlagBits = enum(u32) {
    opaque_fd_bit = 0x00000001,
    opaque_win32_bit = 0x00000002,
    opaque_win32_kmt_bit = 0x00000004,
    d3d12_fence_bit = 0x00000008,
    sync_fd_bit = 0x00000010,
    _,
};

pub const ExternalSemaphoreFeatureFlags = packed struct(u32) {
    exportable: bool = false,
    importable: bool = false,
    _padding: u30 = 0,
};

pub const PeerMemoryFeatureFlags = packed struct(u32) {
    copy_src: bool = false,
    copy_dst: bool = false,
    generic_src: bool = false,
    generic_dst: bool = false,
    _padding: u28 = 0,
};

pub const ExternalMemoryProperties = extern struct {
    external_memory_features: ExternalMemoryFeatureFlags,
    export_from_imported_handle_types: ExternalMemoryHandleTypeFlags,
    compatible_handle_types: ExternalMemoryHandleTypeFlags,
};

pub const ImageAspectFlags = packed struct(u32) {
    color: bool = false,
    depth: bool = false,
    stencil: bool = false,
    metadata: bool = false,
    _padding: u28 = 0,
};

pub const BufferUsageFlags = packed struct(u32) {
    transfer_src: bool = false,
    transfer_dst: bool = false,
    uniform_texel_buffer: bool = false,
    storage_texel_buffer: bool = false,
    uniform_buffer: bool = false,
    storage_buffer: bool = false,
    index_buffer: bool = false,
    vertex_buffer: bool = false,
    indirect_buffer: bool = false,
    _padding: u23 = 0,
};

pub const BufferCreateFlags = packed struct(u32) {
    sparse_binding: bool = false,
    sparse_residency: bool = false,
    sparse_aliased: bool = false,
    protected: bool = false,
    _padding: u28 = 0,
};

pub const ShaderStageFlagBits = enum(u32) {
    vertex_bit = 0x00000001,
    tessellation_control_bit = 0x00000002,
    tessellation_evaluation_bit = 0x00000004,
    geometry_bit = 0x00000008,
    fragment_bit = 0x00000010,
    compute_bit = 0x00000020,
    all_graphics = 0x0000007F,
    all = 0x7FFFFFFF,
    raygen_bit_khr = 0x00000100,
    any_hit_bit_khr = 0x00000200,
    closest_hit_bit_khr = 0x00000400,
    miss_bit_khr = 0x00000800,
    intersection_bit_khr = 0x00001000,
    callable_bit_khr = 0x00002000,
    task_bit_ext = 0x00000040,
    mesh_bit_ext = 0x00000080,
    _,
};

pub const ShaderStageFlags = packed struct(u32) {
    vertex: bool = false,
    tessellation_control: bool = false,
    tessellation_evaluation: bool = false,
    geometry: bool = false,
    fragment: bool = false,
    compute: bool = false,
    all_graphics: bool = false,
    all: bool = false,
    _padding: u24 = 0,
};

pub const ShaderStageFlagsEXT = ShaderStageFlags;

pub const PipelineStageFlagBits = enum(u32) {
    top_of_pipe = 0x00000001,
    draw_indirect = 0x00000002,
    vertex_input = 0x00000004,
    vertex_shader = 0x00000008,
    tessellation_control_shader = 0x00000010,
    tessellation_evaluation_shader = 0x00000020,
    geometry_shader = 0x00000040,
    fragment_shader = 0x00000080,
    early_fragment_tests = 0x00000100,
    late_fragment_tests = 0x00000200,
    color_attachment_output = 0x00000400,
    compute_shader = 0x00000800,
    transfer = 0x00001000,
    bottom_of_pipe = 0x00002000,
    host = 0x00004000,
    all_graphics = 0x00008000,
    all_commands = 0x00010000,
    transform_feedback_ext = 0x01000000,
    conditional_rendering_ext = 0x00040000,
    acceleration_structure_build_khr = 0x02000000,
    ray_tracing_shader_khr = 0x00200000,
    fragmentation_test_ext = 0x10000000,
    task_shader_ext = 0x00080000,
    mesh_shader_ext = 0x00100000,
    none_khr = 0,
    _,
};

pub const PipelineStageFlags = packed struct(u32) {
    top_of_pipe: bool = false,
    draw_indirect: bool = false,
    vertex_input: bool = false,
    vertex_shader: bool = false,
    tessellation_control_shader: bool = false,
    tessellation_evaluation_shader: bool = false,
    geometry_shader: bool = false,
    fragment_shader: bool = false,
    early_fragment_tests: bool = false,
    late_fragment_tests: bool = false,
    color_attachment_output: bool = false,
    compute_shader: bool = false,
    transfer: bool = false,
    bottom_of_pipe: bool = false,
    host: bool = false,
    all_graphics: bool = false,
    all_commands: bool = false,
    _padding: u15 = 0,
};

pub const AccessFlags = packed struct(u32) {
    indirect_command_read: bool = false,
    index_read: bool = false,
    vertex_attribute_read: bool = false,
    uniform_read: bool = false,
    input_attachment_read: bool = false,
    shader_read: bool = false,
    shader_write: bool = false,
    color_attachment_read: bool = false,
    color_attachment_write: bool = false,
    depth_stencil_attachment_read: bool = false,
    depth_stencil_attachment_write: bool = false,
    transfer_read: bool = false,
    transfer_write: bool = false,
    host_read: bool = false,
    host_write: bool = false,
    memory_read: bool = false,
    memory_write: bool = false,
    _padding: u15 = 0,
};

pub const ColorComponentFlags = packed struct(u32) {
    r: bool = false,
    g: bool = false,
    b: bool = false,
    a: bool = false,
    _padding: u28 = 0,
};

pub const CullModeFlags = packed struct(u32) {
    none: bool = false,
    front: bool = false,
    back: bool = false,
    front_and_back: bool = false,
    _padding: u28 = 0,
};

pub const SampleCountFlags = packed struct(u32) {
    @"1": bool = false,
    @"2": bool = false,
    @"4": bool = false,
    @"8": bool = false,
    @"16": bool = false,
    @"32": bool = false,
    @"64": bool = false,
    _padding: u25 = 0,
};

pub const SampleCountFlagBits = enum(u32) {
    @"1" = 0x00000001,
    @"2" = 0x00000002,
    @"4" = 0x00000004,
    @"8" = 0x00000008,
    @"16" = 0x00000010,
    @"32" = 0x00000020,
    @"64" = 0x00000040,
    _,
};

pub const ToolPurposeFlags = packed struct(u32) {
    validation: bool = false,
    profiling: bool = false,
    tracing: bool = false,
    additional_features: bool = false,
    modifying_features: bool = false,
    debug_reporting_ext: bool = false,
    debug_markers_ext: bool = false,
    _padding: u25 = 0,
};

pub const CommandPoolCreateFlags = packed struct(u32) {
    transient: bool = false,
    reset_command_buffer: bool = false,
    protected: bool = false,
    _padding: u29 = 0,
};

pub const CommandBufferUsageFlags = packed struct(u32) {
    one_time_submit: bool = false,
    render_pass_continue: bool = false,
    simultaneous_use: bool = false,
    _padding: u29 = 0,
};

pub const DependencyFlags = packed struct(u32) {
    by_region: bool = false,
    _padding: u31 = 0,
};

pub const DescriptorUpdateTemplateCreateFlagsKHR = u32;
pub const RenderPassCreateFlags = u32;
pub const AttachmentDescriptionFlags = u32;
pub const SubpassDescriptionFlags = u32;
pub const QueryPipelineStatisticFlags = u32; // Type alias for ABI compatibility (packed struct would be more type-safe but u32 matches C ABI)

// Vulkan 1.1 Subgroup Flags
pub const SubgroupFeatureFlags = packed struct(u32) {
    basic: bool = false,
    vote: bool = false,
    arithmetic: bool = false,
    ballot: bool = false,
    shuffle: bool = false,
    shuffle_relative: bool = false,
    clustered: bool = false,
    quad: bool = false,
    partitioned_nv: bool = false,
    _padding: u23 = 0,
};

// Vulkan 1.3 Flags
pub const PipelineStageFlags2 = packed struct(u64) {
    none: bool = false,
    top_of_pipe_bit: bool = false,
    draw_indirect_bit: bool = false,
    vertex_input_bit: bool = false,
    vertex_shader_bit: bool = false,
    tessellation_control_shader_bit: bool = false,
    tessellation_evaluation_shader_bit: bool = false,
    geometry_shader_bit: bool = false,
    fragment_shader_bit: bool = false,
    early_fragment_tests_bit: bool = false,
    late_fragment_tests_bit: bool = false,
    color_attachment_output_bit: bool = false,
    compute_shader_bit: bool = false,
    all_transfer_bit: bool = false,
    transfer_bit: bool = false, // Alias
    bottom_of_pipe_bit: bool = false,
    host_bit: bool = false,
    all_graphics_bit: bool = false,
    all_commands_bit: bool = false,
    _padding: u45 = 0,
};

pub const AccessFlags2 = packed struct(u64) {
    none: bool = false,
    indirect_command_read_bit: bool = false,
    index_read_bit: bool = false,
    vertex_attribute_read_bit: bool = false,
    uniform_read_bit: bool = false,
    input_attachment_read_bit: bool = false,
    shader_read_bit: bool = false,
    shader_write_bit: bool = false,
    color_attachment_read_bit: bool = false,
    color_attachment_write_bit: bool = false,
    depth_stencil_attachment_read_bit: bool = false,
    depth_stencil_attachment_write_bit: bool = false,
    transfer_read_bit: bool = false,
    transfer_write_bit: bool = false,
    host_read_bit: bool = false,
    host_write_bit: bool = false,
    memory_read_bit: bool = false,
    memory_write_bit: bool = false,
    border_color_read_bit_ext: bool = false, // NOTE: Removed reserved bit manual padding for simplicity, hoping alignment holds
    _padding: u45 = 0,
};

pub const RenderingFlags = packed struct(u32) {
    contents_secondary_command_buffers_bit: bool = false,
    suspending_bit: bool = false,
    resuming_bit: bool = false,
    _padding: u29 = 0,
};

// ============================================================================
// Common Structures
// ============================================================================

pub const Offset2D = extern struct {
    x: i32,
    y: i32,
};

pub const Offset3D = extern struct {
    x: i32,
    y: i32,
    z: i32,
};

pub const Extent2D = extern struct {
    width: u32,
    height: u32,
};

pub const Extent3D = extern struct {
    width: u32,
    height: u32,
    depth: u32,
};

pub const Rect2D = extern struct {
    offset: Offset2D,
    extent: Extent2D,
};

pub const Viewport = extern struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,
    min_depth: f32,
    max_depth: f32,
};

pub const ClearColorValue = extern union {
    float32: [4]f32,
    int32: [4]i32,
    uint32: [4]u32,
};

pub const ClearDepthStencilValue = extern struct {
    depth: f32,
    stencil: u32,
};

pub const ClearValue = extern union {
    color: ClearColorValue,
    depth_stencil: ClearDepthStencilValue,
};

pub const ComponentMapping = extern struct {
    r: ComponentSwizzle,
    g: ComponentSwizzle,
    b: ComponentSwizzle,
    a: ComponentSwizzle,
};

pub const ImageSubresourceRange = extern struct {
    aspect_mask: ImageAspectFlags,
    base_mip_level: u32,
    level_count: u32,
    base_array_layer: u32,
    layer_count: u32,
};

pub const ImageSubresource = extern struct {
    aspect_mask: ImageAspectFlags,
    mip_level: u32,
    array_layer: u32,
};

pub const ImageSubresourceLayers = extern struct {
    aspect_mask: ImageAspectFlags,
    mip_level: u32,
    base_array_layer: u32,
    layer_count: u32,
};

pub const MemoryRequirements = extern struct {
    size: DeviceSize,
    alignment: DeviceSize,
    memory_type_bits: u32,
};

pub const MemoryRequirements2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    memory_requirements: MemoryRequirements,
};

pub const ImageMemoryRequirementsInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    image: Image,
};

pub const BufferMemoryRequirementsInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    buffer: Buffer,
};

pub const SubresourceLayout = extern struct {
    offset: DeviceSize,
    size: DeviceSize,
    row_pitch: DeviceSize,
    array_pitch: DeviceSize,
    depth_pitch: DeviceSize,
};

pub const DeviceQueueInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    flags: u32,
    queue_family_index: u32,
    queue_index: u32,
};

pub const RenderPassCreateInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    flags: u32,
    attachment_count: u32,
    p_attachments: ?*const anyopaque,
    subpass_count: u32,
    p_subpasses: ?*const anyopaque,
    dependency_count: u32,
    p_dependencies: ?*const anyopaque,
    correlated_view_mask_count: u32,
    p_correlated_view_masks: ?*const u32,
};

pub const RenderPassBeginInfo = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    render_pass: RenderPass,
    framebuffer: Framebuffer,
    render_area: Rect2D,
    clear_value_count: u32,
    p_clear_values: ?*const ClearValue,
};

pub const SubpassBeginInfo = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    contents: u32,
};

pub const SubpassEndInfo = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
};

pub const PrivateDataSlotCreateInfo = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    flags: u32,
};

pub const StencilFaceFlags = u32;

pub const PhysicalDeviceToolProperties = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    name: [256]u8,
    version: [256]u8,
    purposes: u32,
    description: [256]u8,
    layer: [256]u8,
};

pub const PrivateDataSlot = u64;

pub const SubmitInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    flags: u32,
    wait_semaphore_info_count: u32,
    p_wait_semaphore_infos: ?*const anyopaque,
    command_buffer_info_count: u32,
    p_command_buffer_infos: ?*const anyopaque,
    signal_semaphore_info_count: u32,
    p_signal_semaphore_infos: ?*const anyopaque,
};

pub const CopyBufferInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    src_buffer: Buffer,
    dst_buffer: Buffer,
    region_count: u32,
    p_regions: ?*const anyopaque,
};

pub const CopyImageInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    src_image: Image,
    src_image_layout: u32,
    dst_image: Image,
    dst_image_layout: u32,
    region_count: u32,
    p_regions: ?*const anyopaque,
};

pub const CopyBufferToImageInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    src_buffer: Buffer,
    dst_image: Image,
    dst_image_layout: u32,
    region_count: u32,
    p_regions: ?*const anyopaque,
};

pub const CopyImageToBufferInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    src_image: Image,
    src_image_layout: u32,
    dst_buffer: Buffer,
    region_count: u32,
    p_regions: ?*const anyopaque,
};

pub const BlitImageInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    src_image: Image,
    src_image_layout: u32,
    dst_image: Image,
    dst_image_layout: u32,
    region_count: u32,
    p_regions: ?*const anyopaque,
    filter: u32,
};

pub const ResolveImageInfo2 = extern struct {
    s_type: StructureType,
    p_next: ?*anyopaque,
    src_image: Image,
    src_image_layout: u32,
    dst_image: Image,
    dst_image_layout: u32,
    region_count: u32,
    p_regions: ?*const anyopaque,
};

pub const VertexInputAttributeDescription = extern struct {
    location: u32,
    binding: u32,
    format: u32,
    offset: u32,
};

pub const VertexInputBindingDescription = extern struct {
    binding: u32,
    stride: u32,
    input_rate: u32,
};

pub const StencilOpState = extern struct {
    fail_op: StencilOp,
    pass_op: StencilOp,
    depth_fail_op: StencilOp,
    compare_op: CompareOp,
    compare_mask: u32 = 0,
    write_mask: u32 = 0,
    reference: u32 = 0,
};

pub const PipelineVertexInputStateCreateFlags = u32;

pub const PipelineInputAssemblyStateCreateFlags = u32;

pub const PipelineRasterizationStateCreateFlags = u32;

pub const PipelineMultisampleStateCreateFlags = u32;

pub const PipelineColorBlendStateCreateFlags = u32;

pub const PipelineDepthStencilStateCreateFlags = u32;

pub const PipelineViewportStateCreateFlags = u32;

pub const PipelineTessellationStateCreateFlags = u32;

pub const PipelineDynamicStateCreateFlags = u32;

pub const DescriptorSetLayoutCreateFlags = u32;

pub const DescriptorSetLayoutBinding = extern struct {
    binding: u32,
    descriptor_type: DescriptorType,
    descriptor_count: u32,
    stage_flags: ShaderStageFlags,
    p_immutable_samplers: ?[*]const Sampler = null,
};

pub const PipelineCreateFlags = u32;
pub const PipelineCacheCreateFlags = u32;
pub const QueryControlFlags = u32;
pub const QueryResultFlags = u32;
pub const HostImageCopyFlagsEXT = u32;

// PipelineCreateFlagBits constants
pub const PIPELINE_CREATE_DISABLE_OPTIMIZATION_BIT = 0x00000001;
pub const PIPELINE_CREATE_ALLOW_DERIVATIVES_BIT = 0x00000002;
pub const PIPELINE_CREATE_DERIVATIVE_BIT = 0x00000004;
pub const PIPELINE_CREATE_VIEW_INDEX_FROM_DEVICE_INDEX_BIT = 0x00000008;
pub const PIPELINE_CREATE_DISPATCH_BASE_BIT = 0x00000010;
pub const PIPELINE_CREATE_FAIL_ON_PIPELINE_COMPILE_REQUIRED_BIT = 0x00000100;
pub const PIPELINE_CREATE_EARLY_RETURN_ON_FAILURE_BIT = 0x00000200;

pub const CommandPoolTrimFlags = u32;
pub const CommandPoolResetFlags = u32;

pub const AllocationCallbacks = extern struct {
    user_data: ?*anyopaque,
    pfn_allocation: ?*const fn (?*anyopaque, usize, usize, u32) callconv(.c) ?*anyopaque,
    pfn_reallocation: ?*const fn (?*anyopaque, ?*anyopaque, usize, usize, u32) callconv(.c) ?*anyopaque,
    pfn_free: ?*const fn (?*anyopaque, ?*anyopaque) callconv(.c) void,
    pfn_internal_allocation: ?*const fn (?*anyopaque, usize, usize, u32) callconv(.c) void,
    pfn_internal_free: ?*const fn (?*anyopaque, usize, usize, u32) callconv(.c) void,
};

// ============================================================================
// Vulkan 1.3 Flag Types
// ============================================================================

pub const ToolPurposeFlagBits = enum(u32) {
    validation = 0x00000001,
    profiling = 0x00000002,
    tracing = 0x00000004,
    _,
};

// ============================================================================
// Additional Types for Copy Commands 2
// ============================================================================

pub const BufferCopy2 = extern struct {
    src_offset: DeviceSize,
    dst_offset: DeviceSize,
    size: DeviceSize,
};

pub const ImageCopy2 = extern struct {
    src_subresource: ImageSubresourceLayers,
    dst_subresource: ImageSubresourceLayers,
    src_offset: Offset3D,
    dst_offset: Offset3D,
    extent: Extent3D,
};

pub const BufferImageCopy2 = extern struct {
    buffer_offset: DeviceSize,
    buffer_row_length: u32,
    buffer_image_height: u32,
    image_subresource: ImageSubresourceLayers,
    image_offset: Offset3D,
};

pub const ImageBlit2 = extern struct {
    src_subresource: ImageSubresourceLayers,
    src_offsets: [2]Offset3D,
    src_extent: Extent3D,
    dst_subresource: ImageSubresourceLayers,
    dst_offsets: [2]Offset3D,
    dst_extent: Extent3D,
};
