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
};

pub const PhysicalDeviceVulkan14Properties = extern struct {
    s_type: types.StructureType = .physical_device_vulkan_1_4_properties,
    p_next: ?*anyopaque = null,
    line_sub_pixel_precision_bits: u32,
};

// Add promoted extension structs here, e.g., from maintenance5
pub const DeviceImageSubresourceInfoKHR = extern struct {
    s_type: types.StructureType = .device_image_subresource_info,
    p_next: ?*const anyopaque = null,
    image: types.Image,
    p_create_info: *const core_1_0.ImageCreateInfo,
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

pub const HostImageCopyDeviceToHostInfoEXT = extern struct {
    s_type: types.StructureType = .host_image_copy_device_to_host_info_ext,
    p_next: ?*const anyopaque = null,
    flags: types.HostImageCopyFlagsEXT,
    dst_host_pointer: types.HostImageCopyDeviceToHostInfoEXT.HostPointer,
    dst_memory_layout: types.SubresourceLayout2KHR,
    src_image: types.Image,
    src_image_layout: types.ImageLayout,
    image_subresource: types.ImageSubresourceLayers,
    image_offset: types.Offset3D,
    image_extent: types.Extent3D,

    pub const HostPointer = extern union {
        uint8: ?[*]u8,
        uint16: ?[*]u16,
        uint32: ?[*]u32,
        uint64: ?[*]u64,
        sint8: ?[*]i8,
        sint16: ?[*]i16,
        sint32: ?[*]i32,
        sint64: ?[*]i64,
        float32: ?[*]f32,
        float64: ?[*]f64,
    };
};

// Add more structs as needed for other extensions
