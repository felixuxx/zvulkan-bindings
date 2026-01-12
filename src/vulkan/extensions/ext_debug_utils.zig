//! VK_EXT_debug_utils - Debug Utils Extension

const std = @import("std");
const types = @import("../types.zig");

// ============================================================================
// Structures
// ============================================================================

pub const DebugUtilsObjectNameInfoEXT = extern struct {
    s_type: types.StructureType = .debug_utils_object_name_info_ext,
    p_next: ?*const anyopaque = null,
    object_type: types.ObjectType,
    object_handle: u64,
    p_object_name: [*:0]const u8,
};

pub const DebugUtilsObjectTagInfoEXT = extern struct {
    s_type: types.StructureType = .debug_utils_object_tag_info_ext,
    p_next: ?*const anyopaque = null,
    object_type: types.ObjectType,
    object_handle: u64,
    tag_name: [*:0]const u8,
    p_tag: ?*const anyopaque = null,
    tag_size: usize,
};

pub const DebugUtilsLabelEXT = extern struct {
    s_type: types.StructureType = .debug_utils_label_ext,
    p_next: ?*const anyopaque = null,
    p_label_name: [*:0]const u8,
    color: [4]f32,
};

pub const DebugUtilsMessengerCallbackDataEXT = extern struct {
    s_type: types.StructureType = .debug_utils_messenger_callback_data_ext,
    p_next: ?*const anyopaque = null,
    flags: DebugUtilsMessengerCallbackDataFlagsEXT,
    p_message_id_name: [*:0]const u8,
    message_id_number: i32,
    p_message: [*:0]const u8,
    queue_label_count: u32,
    p_queue_labels: [*]const DebugUtilsLabelEXT,
    cmd_buf_label_count: u32,
    p_cmd_buf_labels: [*]const DebugUtilsLabelEXT,
    object_count: u32,
    p_objects: [*]const DebugUtilsObjectNameInfoEXT,
};

pub const DebugUtilsMessengerCreateInfoEXT = extern struct {
    s_type: types.StructureType = .debug_utils_messenger_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: DebugUtilsMessengerCreateFlagsEXT,
    message_severity: DebugUtilsMessageSeverityFlagsEXT,
    message_type: DebugUtilsMessageTypeFlagsEXT,
    pfn_user_callback: PFN_vkDebugUtilsMessengerCallbackEXT,
    p_user_data: ?*anyopaque = null,
};

// ============================================================================
// Enums and Flags
// ============================================================================

pub const DebugUtilsMessageSeverityFlagsEXT = u32;

pub const DebugUtilsMessageSeverityFlagBitsEXT = enum(u32) {
    verbose = 0x00000001,
    info = 0x00000010,
    warning = 0x00000100,
    error_bit = 0x00001000,
    _,
};

pub const DebugUtilsMessageTypeFlagsEXT = u32;

pub const DebugUtilsMessageTypeFlagBitsEXT = enum(u32) {
    general = 0x00000001,
    validation = 0x00000002,
    performance = 0x00000004,
    device_address_binding = 0x00000008,
    _,
};

// Re-export the messenger handle type for consistent access
pub const DebugUtilsMessengerEXT = u64;

pub const DebugUtilsMessengerCallbackDataFlagsEXT = u32;

pub const DebugUtilsMessengerCreateFlagsEXT = u32;

// ============================================================================
// Function Pointer Types
// ============================================================================

pub const PFN_vkDebugUtilsMessengerCallbackEXT = *const fn (
    DebugUtilsMessageSeverityFlagsEXT,
    DebugUtilsMessageTypeFlagsEXT,
    *const DebugUtilsMessengerCallbackDataEXT,
    ?*anyopaque,
) callconv(.c) types.Bool32;
