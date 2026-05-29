//! VK_KHR_dynamic_rendering extension
//! Simplifies render pass creation for modern engines

const types = @import("../types.zig");
const core_1_3 = @import("../core_1_3.zig");
const khr_fragment_shading_rate = @import("khr_fragment_shading_rate.zig");

pub const KHR_DYNAMIC_RENDERING_EXTENSION_NAME = "VK_KHR_dynamic_rendering";

// == Enums ==

pub const RenderingFlagBitsKHR = packed struct(u32) {
    contents_secondary_command_buffers_khr: bool = false,
    suspending_khr: bool = false,
    resuming_khr: bool = false,
    _padding: u29 = 0,
};

pub const RenderingInfoFlagsKHR = types.RenderingFlags;

// == Structures (re-exported from core_1_3) ==

pub const RenderingInfo = core_1_3.RenderingInfo;
pub const RenderingAttachmentInfo = core_1_3.RenderingAttachmentInfo;
pub const PipelineRenderingCreateInfo = core_1_3.PipelineRenderingCreateInfo;
pub const PhysicalDeviceDynamicRenderingFeatures = core_1_3.PhysicalDeviceDynamicRenderingFeatures;

// == Extension-specific structures ==

pub const RenderingFragmentDensityMapAttachmentInfoEXT = extern struct {
    s_type: types.StructureType = .rendering_fragment_density_map_attachment_info_ext,
    p_next: ?*const anyopaque = null,
    image_view: types.ImageView = 0,
    image_layout: types.ImageLayout,
};

pub const RenderingFragmentShadingRateAttachmentInfoKHR = khr_fragment_shading_rate.RenderingFragmentShadingRateAttachmentInfoKHR;

pub const PhysicalDeviceDynamicRenderingFeaturesKHR = PhysicalDeviceDynamicRenderingFeatures;
