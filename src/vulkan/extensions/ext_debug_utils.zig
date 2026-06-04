//! VK_EXT_debug_utils extension
//! Debugging and validation utilities for Vulkan

const types = @import("../types.zig");

pub const EXT_DEBUG_UTILS_EXTENSION_NAME = "VK_EXT_debug_utils";

pub const EXT_DEBUG_UTILS_SPEC_VERSION = 2;

// == Enums ==

pub const DebugUtilsMessageSeverityFlagBitsEXT = enum(u32) {
    verbose = 0x00000001,
    info = 0x00000010,
    warning = 0x00000100,
    @"error" = 0x00001000,
    _,
};

pub const DebugUtilsMessageTypeFlagBitsEXT = enum(u32) {
    general = 0x00000001,
    validation = 0x00000002,
    performance = 0x00000004,
    device_address_binding = 0x00000008,
    _,
};

// == Flags ==

pub const DebugUtilsMessageSeverityFlagsEXT = packed struct(u32) {
    verbose: bool = false,
    _pad_after_verbose: u3 = 0,
    info: bool = false,
    _pad_after_info: u3 = 0,
    warning: bool = false,
    _pad_after_warning: u3 = 0,
    @"error": bool = false,
    _padding: u19 = 0,
};

comptime {
    const v1 = @as(u32, @bitCast(DebugUtilsMessageSeverityFlagsEXT{ .verbose = true }));
    if (v1 != 0x00000001) @compileError("verbose bit mismatch");
    const v2 = @as(u32, @bitCast(DebugUtilsMessageSeverityFlagsEXT{ .info = true }));
    if (v2 != 0x00000010) @compileError("info bit mismatch");
    const v3 = @as(u32, @bitCast(DebugUtilsMessageSeverityFlagsEXT{ .warning = true }));
    if (v3 != 0x00000100) @compileError("warning bit mismatch");
    const v4 = @as(u32, @bitCast(DebugUtilsMessageSeverityFlagsEXT{ .@"error" = true }));
    if (v4 != 0x00001000) @compileError("error bit mismatch");
}

pub const DebugUtilsMessageTypeFlagsEXT = packed struct(u32) {
    general: bool = false,
    validation: bool = false,
    performance: bool = false,
    device_address_binding: bool = false,
    _padding: u28 = 0,
};

pub const DebugUtilsMessengerCallbackDataFlagsEXT = packed struct(u32) {
    _padding: u32 = 0,
};

pub const DebugUtilsMessengerCreateFlagsEXT = packed struct(u32) {
    _padding: u32 = 0,
};

// == Callback Type ==

pub const PFN_vkDebugUtilsMessengerCallbackEXT = *const fn (
    message_severity: DebugUtilsMessageSeverityFlagBitsEXT,
    message_types: DebugUtilsMessageTypeFlagsEXT,
    p_callback_data: *const DebugUtilsMessengerCallbackDataEXT,
    p_user_data: ?*anyopaque,
) callconv(.c) types.Bool32;

// == Structures ==

pub const DebugUtilsLabelEXT = extern struct {
    s_type: types.StructureType = .debug_utils_label_ext,
    p_next: ?*const anyopaque = null,
    p_label_name: [*:0]const u8,
    color: [4]f32,
};

pub const DebugUtilsObjectNameInfoEXT = extern struct {
    s_type: types.StructureType = .debug_utils_object_name_info_ext,
    p_next: ?*const anyopaque = null,
    object_type: types.ObjectType,
    object_handle: u64,
    p_object_name: ?[*:0]const u8,
};

pub const DebugUtilsMessengerCallbackDataEXT = extern struct {
    s_type: types.StructureType = .debug_utils_messenger_callback_data_ext,
    p_next: ?*const anyopaque = null,
    flags: DebugUtilsMessengerCallbackDataFlagsEXT = .{},
    p_message_id_name: ?[*:0]const u8,
    message_id_number: i32,
    p_message: [*:0]const u8,
    queue_label_count: u32,
    p_queue_labels: ?[*]const DebugUtilsLabelEXT,
    cmd_buf_label_count: u32,
    p_cmd_buf_labels: ?[*]const DebugUtilsLabelEXT,
    object_count: u32,
    p_objects: ?[*]const DebugUtilsObjectNameInfoEXT,
};

pub const DebugUtilsMessengerCreateInfoEXT = extern struct {
    s_type: types.StructureType = .debug_utils_messenger_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: DebugUtilsMessengerCreateFlagsEXT = .{},
    message_severity: DebugUtilsMessageSeverityFlagsEXT,
    message_type: DebugUtilsMessageTypeFlagsEXT,
    pfn_user_callback: PFN_vkDebugUtilsMessengerCallbackEXT,
    p_user_data: ?*anyopaque = null,
};

pub const DebugUtilsObjectTagInfoEXT = extern struct {
    s_type: types.StructureType = .debug_utils_object_tag_info_ext,
    p_next: ?*const anyopaque = null,
    object_type: types.ObjectType,
    object_handle: u64,
    tag_name: u64,
    tag_size: usize,
    p_tag: ?*const anyopaque,
};
