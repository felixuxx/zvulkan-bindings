//! VK_KHR_push_descriptor extension
//! Update descriptor sets without rebuilding pipelines

const types = @import("../types.zig");
const constants = @import("../constants.zig");

pub const KHR_PUSH_DESCRIPTOR_EXTENSION_NAME = "VK_KHR_push_descriptor";

// ============================================================================
// Structures
// ============================================================================

pub const PhysicalDevicePushDescriptorPropertiesKHR = extern struct {
    s_type: types.StructureType = .physical_device_push_descriptor_properties_khr,
    p_next: ?*const anyopaque = null,
    max_push_descriptors: u32,
    max_push_descriptors_update_after_bind: u32,
    max_push_descriptors_update_after_bind_with_template: u32,
    max_inline_uniform_block_update_after_bind: u32,
    max_inline_uniform_block_update_after_bind_with_template: u32,
    inline_uniform_block_update_after_bind_descriptor_type: [types.DescriptorType]u32,
};

pub const WriteDescriptorSetInlineUniformBlock = extern struct {
    s_type: types.StructureType = .write_descriptor_set_inline_uniform_block,
    p_next: ?*const anyopaque = null,
    data_size: u32,
    p_data: [*]const anyopaque,
    descriptor_type: types.DescriptorType,
};

pub const WriteDescriptorSetInlineUniformBlockKHR = WriteDescriptorSetInlineUniformBlock;

pub const PushDescriptorSetInfoKHR = extern struct {
    s_type: types.StructureType = .push_descriptor_set_info_khr,
    p_next: ?*const anyopaque = null,
    descriptor_set: types.DescriptorSet,
    buffer_offset: u32,
    range: u32,
};

pub const PushDescriptorUpdateInfoKHR = extern struct {
    s_type: types.StructureType = .push_descriptor_update_info_khr,
    p_next: ?*const anyopaque = null,
    descriptor_set: types.DescriptorSet,
    descriptor_write_count: u32,
    p_descriptor_writes: ?[*]const types.WriteDescriptorSet = null,
    descriptor_copy_count: u32,
    p_descriptor_copies: ?[*]const types.CopyDescriptorSet = null,
    inline_uniform_block_write_count: u32,
    p_inline_uniform_block_writes: ?[*]const WriteDescriptorSetInlineUniformBlockKHR = null,
};
