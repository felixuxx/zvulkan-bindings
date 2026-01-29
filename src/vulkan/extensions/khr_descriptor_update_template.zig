//! VK_KHR_descriptor_update_template extension
//! Efficient descriptor set updates using templates

const types = @import("../types.zig");
const constants = @import("../constants.zig");

pub const KHR_DESCRIPTOR_UPDATE_TEMPLATE_EXTENSION_NAME = "VK_KHR_descriptor_update_template";

// ============================================================================
// Enums
// ============================================================================

pub const DescriptorUpdateTemplateTypeKHR = enum(i32) {
    descriptor_set_khr = 0,
    push_descriptors_khr = 1,
};

// ============================================================================
// Structures
// ============================================================================

pub const DescriptorUpdateTemplateCreateInfoKHR = extern struct {
    s_type: types.StructureType = .descriptor_update_template_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: types.DescriptorUpdateTemplateCreateFlagsKHR = .{},
    descriptor_update_entry_count: u32 = 0,
    p_descriptor_update_entries: [*]const DescriptorUpdateTemplateEntryKHR,
    template_type: DescriptorUpdateTemplateTypeKHR,
    descriptor_set_layout: types.DescriptorSetLayout,
    pipeline_bind_point: types.PipelineBindPoint,
    pipeline_layout: types.PipelineLayout,
    set: u32 = 0,
};

pub const DescriptorUpdateTemplateEntryKHR = extern struct {
    descriptor_type: types.DescriptorType,
    count: u32 = 0,
    offset: usize = 0,
    stride: usize = 0,
};

pub const DescriptorUpdateTemplateKHR = extern struct {
    s_type: types.StructureType = .descriptor_update_template_khr,
    p_next: ?*const anyopaque = null,
    descriptor_update_template_type: DescriptorUpdateTemplateTypeKHR,
    flags: types.DescriptorUpdateTemplateCreateFlagsKHR = .{},
    descriptor_set_layout: types.DescriptorSetLayout,
    pipeline_bind_point: types.PipelineBindPoint,
    pipeline_layout: types.PipelineLayout,
    set: u32 = 0,
};

pub const DescriptorDataInlineUniformBlock = extern struct {
    type: types.DescriptorType,
    size: u32,
    data: ?*const anyopaque,
};

pub const WriteDescriptorSetInlineUniformBlock = extern struct {
    s_type: types.StructureType = .write_descriptor_set_inline_uniform_block,
    p_next: ?*const anyopaque = null,
    descriptor_set: types.DescriptorSet,
    data: DescriptorDataInlineUniformBlock,
};

pub const DescriptorUpdateTemplateCreateFlagsKHR = types.DescriptorUpdateTemplateCreateFlagsKHR;
