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

    // Vulkan 1.3
    physical_device_vulkan_1_3_features = 53,
    physical_device_vulkan_1_3_properties = 54,
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
    wayland_surface_create_info_khr = 1000006000,
    win32_surface_create_info_khr = 1000009000,
    xlib_surface_create_info_khr = 1000004000,
    xcb_surface_create_info_khr = 1000005000,
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
    present_src_khr = 1000001002,
    _,
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
    _,
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
    _,
};

pub const Filter = enum(i32) {
    nearest = 0,
    linear = 1,
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
    sType: StructureType,
    pNext: ?*anyopaque,
    memoryRequirements: MemoryRequirements,
};

pub const ImageMemoryRequirementsInfo2 = extern struct {
    sType: StructureType,
    pNext: ?*anyopaque,
    image: Image,
};

pub const BufferMemoryRequirementsInfo2 = extern struct {
    sType: StructureType,
    pNext: ?*anyopaque,
    buffer: Buffer,
};

pub const AllocationCallbacks = extern struct {
    user_data: ?*anyopaque,
    pfn_allocation: ?*const fn (?*anyopaque, usize, usize, u32) callconv(.c) ?*anyopaque,
    pfn_reallocation: ?*const fn (?*anyopaque, ?*anyopaque, usize, usize, u32) callconv(.c) ?*anyopaque,
    pfn_free: ?*const fn (?*anyopaque, ?*anyopaque) callconv(.c) void,
    pfn_internal_allocation: ?*const fn (?*anyopaque, usize, u32, u32) callconv(.c) void,
    pfn_internal_free: ?*const fn (?*anyopaque, usize, u32, u32) callconv(.c) void,
};
