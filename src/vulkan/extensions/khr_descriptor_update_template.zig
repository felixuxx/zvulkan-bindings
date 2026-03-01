//! VK_KHR_descriptor_update_template extension
//! Efficient descriptor set updates using templates

const types = @import("../types.zig");

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
    flags: types.DescriptorUpdateTemplateCreateFlagsKHR = 0,
    descriptor_update_entry_count: u32,
    p_descriptor_update_entries: [*]const DescriptorUpdateTemplateEntryKHR,
    template_type: DescriptorUpdateTemplateTypeKHR,
    descriptor_set_layout: types.DescriptorSetLayout,
    pipeline_bind_point: types.PipelineBindPoint,
    pipeline_layout: types.PipelineLayout,
    set: u32,
};

pub const DescriptorUpdateTemplateEntryKHR = extern struct {
    dst_binding: u32,
    dst_array_element: u32,
    descriptor_count: u32,
    descriptor_type: types.DescriptorType,
    offset: usize,
    stride: usize,
};

pub const DescriptorUpdateTemplateKHR = types.DescriptorUpdateTemplateKHR;
