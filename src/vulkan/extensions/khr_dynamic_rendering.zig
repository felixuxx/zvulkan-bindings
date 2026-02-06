//! VK_KHR_dynamic_rendering extension
//! Simplifies render pass creation for modern engines

const types = @import("../types.zig");
const constants = @import("../constants.zig");

pub const KHR_DYNAMIC_RENDERING_EXTENSION_NAME = "VK_KHR_dynamic_rendering";

// ============================================================================
// Enums
// ============================================================================

pub const RenderingFlagBitsKHR = packed struct(u32) {
    contents_secondary_command_buffers_khr: bool = false,
    suspending_khr: bool = false,
    king_khr: bool = false,
    _padding: u29 = 0,
};

pub const RenderingInfoFlagsKHR = packed struct(u32) {
    _reserved_bits: types.Flags = 0,
    pub const toInt = types.FlagsMixin(RenderingInfoFlagsKHR).toInt;
    pub const fromInt = types.FlagsMixin(RenderingInfoFlagsKHR).fromInt;
    pub const merge = types.FlagsMixin(RenderingInfoFlagsKHR).merge;
    pub const intersect = types.FlagsMixin(RenderingInfoFlagsKHR).intersect;
    pub const complement = types.FlagsMixin(RenderingInfoFlagsKHR).complement;
    pub const subtract = types.FlagsMixin(RenderingInfoFlagsKHR).subtract;
    pub const contains = types.FlagsMixin(RenderingInfoFlagsKHR).contains;
    pub const format = types.FlagFormatMixin(RenderingInfoFlagsKHR).format;
};

// ============================================================================
// Structures
// ============================================================================

pub const RenderingInfo = extern struct {
    s_type: types.StructureType = .rendering_info,
    p_next: ?*const anyopaque = null,
    flags: RenderingInfoFlagsKHR = .{},
    render_area: types.Rect2D,
    layer_count: u32 = 0,
    view_mask: u32 = 0,
    color_attachment_count: u32 = 0,
    p_color_attachments: ?[*]const RenderingAttachmentInfo = null,
    depth_attachment: ?*const RenderingAttachmentInfo = null,
    stencil_attachment: ?*const RenderingAttachmentInfo = null,
};

pub const RenderingAttachmentInfo = extern struct {
    s_type: types.StructureType = .rendering_attachment_info,
    p_next: ?*const anyopaque = null,
    image_view: types.ImageView = 0,
    image_layout: types.ImageLayout,
    resolve_mode: types.ResolveModeFlags,
    resolve_image_view: types.ImageView = 0,
    resolve_image_layout: types.ImageLayout,
    load_op: types.AttachmentLoadOp,
    store_op: types.AttachmentStoreOp,
    clear_value: types.ClearValue,
};

pub const RenderingFragmentDensityMapAttachmentInfoEXT = extern struct {
    s_type: types.StructureType = .rendering_fragment_density_map_attachment_info_ext,
    p_next: ?*const anyopaque = null,
    image_view: types.ImageView = 0,
    image_layout: types.ImageLayout,
};

pub const RenderingFragmentShadingRateAttachmentInfoKHR = extern struct {
    s_type: types.StructureType = .rendering_fragment_shading_rate_attachment_info_khr,
    p_next: ?*const anyopaque = null,
    image_view: types.ImageView = 0,
    image_layout: types.ImageLayout,
    shading_rate: types.FragmentShadingRateKHR,
};

pub const PhysicalDeviceDynamicRenderingFeatures = extern struct {
    s_type: types.StructureType = .physical_device_dynamic_rendering_features,
    p_next: ?*const anyopaque = null,
    dynamic_rendering: types.Bool32 = 0,
};

pub const PipelineRenderingCreateInfo = extern struct {
    s_type: types.StructureType = .pipeline_rendering_create_info,
    p_next: ?*const anyopaque = null,
    view_mask: u32 = 0,
    color_attachment_count: u32 = 0,
    p_color_attachment_formats: ?[*]const types.Format = null,
    depth_attachment_format: types.Format = .undefined,
    stencil_attachment_format: types.Format = .undefined,
};

pub const PhysicalDeviceDynamicRenderingFeaturesKHR = PhysicalDeviceDynamicRenderingFeatures;

pub const PhysicalDeviceDynamicRenderingProperties = extern struct {
    s_type: types.StructureType = .physical_device_dynamic_rendering_properties,
    p_next: ?*const anyopaque = null,
    max_dynamic_color_attachments: u32 = 0,
    max_dynamic_depth_stencil_attachments: u32 = 0,
    max_dynamic_rendering_samples: types.SampleCountFlagBits = .@"1",
};

pub const PhysicalDeviceDynamicRenderingPropertiesKHR = PhysicalDeviceDynamicRenderingProperties;
