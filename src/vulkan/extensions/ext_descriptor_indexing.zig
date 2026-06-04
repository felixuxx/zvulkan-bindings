//! VK_EXT_descriptor_indexing extension
//! Bindless descriptor support — dynamic indexing, partially-bound sets,
//! variable descriptor counts, and update-after-bind descriptors

const types = @import("../types.zig");

pub const EXT_DESCRIPTOR_INDEXING_EXTENSION_NAME = "VK_EXT_descriptor_indexing";

pub const EXT_DESCRIPTOR_INDEXING_SPEC_VERSION = 2;

pub const DESCRIPTOR_SET_LAYOUT_CREATE_UPDATE_AFTER_BIND_POOL_BIT: u32 = 0x00000002;

// == Flags ==

pub const DescriptorBindingFlags = packed struct(u32) {
    update_after_bind: bool = false,
    update_unused_while_pending: bool = false,
    partially_bound: bool = false,
    variable_descriptor_count: bool = false,
    _padding: u28 = 0,
};

comptime {
    const v1 = @as(u32, @bitCast(DescriptorBindingFlags{ .update_after_bind = true }));
    if (v1 != 0x00000001) @compileError("update_after_bind bit mismatch");
    const v2 = @as(u32, @bitCast(DescriptorBindingFlags{ .update_unused_while_pending = true }));
    if (v2 != 0x00000002) @compileError("update_unused_while_pending bit mismatch");
    const v3 = @as(u32, @bitCast(DescriptorBindingFlags{ .partially_bound = true }));
    if (v3 != 0x00000004) @compileError("partially_bound bit mismatch");
    const v4 = @as(u32, @bitCast(DescriptorBindingFlags{ .variable_descriptor_count = true }));
    if (v4 != 0x00000008) @compileError("variable_descriptor_count bit mismatch");
}

// == Structures ==

pub const DescriptorSetLayoutBindingFlagsCreateInfo = extern struct {
    s_type: types.StructureType = .descriptor_set_layout_binding_flags_create_info,
    p_next: ?*const anyopaque = null,
    binding_count: u32,
    p_binding_flags: [*]const DescriptorBindingFlags,
};

pub const DescriptorSetVariableDescriptorCountAllocateInfo = extern struct {
    s_type: types.StructureType = .descriptor_set_variable_descriptor_count_allocate_info,
    p_next: ?*const anyopaque = null,
    descriptor_set_count: u32,
    p_descriptor_counts: [*]const u32,
};

pub const DescriptorSetVariableDescriptorCountLayoutSupport = extern struct {
    s_type: types.StructureType = .descriptor_set_variable_descriptor_count_layout_support,
    p_next: ?*anyopaque = null,
    max_variable_descriptor_count: u32,
};
