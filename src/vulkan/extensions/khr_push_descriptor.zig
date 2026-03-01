//! VK_KHR_push_descriptor extension
//! Update descriptor sets without rebuilding pipelines

const types = @import("../types.zig");
const core_1_0 = @import("../core_1_0.zig");

pub const KHR_PUSH_DESCRIPTOR_EXTENSION_NAME = "VK_KHR_push_descriptor";

// ============================================================================
// Structures
// ============================================================================

pub const PhysicalDevicePushDescriptorPropertiesKHR = extern struct {
    s_type: types.StructureType = .physical_device_push_descriptor_properties_khr,
    p_next: ?*anyopaque = null,
    max_push_descriptors: u32,
};

pub const WriteDescriptorSetInlineUniformBlock = extern struct {
    s_type: types.StructureType = .write_descriptor_set_inline_uniform_block,
    p_next: ?*const anyopaque = null,
    data_size: u32,
    p_data: ?*const anyopaque = null,
};

pub const WriteDescriptorSetInlineUniformBlockKHR = WriteDescriptorSetInlineUniformBlock;

pub const PushDescriptorSetInfoKHR = extern struct {
    s_type: types.StructureType = .push_descriptor_set_info_khr,
    p_next: ?*const anyopaque = null,
    stage_flags: types.ShaderStageFlags,
    layout: types.PipelineLayout = 0,
    set: u32 = 0,
    descriptor_write_count: u32,
    p_descriptor_writes: [*]const core_1_0.WriteDescriptorSet,
};
