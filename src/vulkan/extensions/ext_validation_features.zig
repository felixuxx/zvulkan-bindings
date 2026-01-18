//! VK_EXT_validation_features extension
//! Validation layer controls

const types = @import("../types.zig");
const constants = @import("../constants.zig");

pub const EXT_VALIDATION_FEATURES_EXTENSION_NAME = "VK_EXT_validation_features";

// ============================================================================
// Enums
// ============================================================================

pub const ValidationFeatureEnableEXT = enum(i32) {
    gpu_assisted = 0,
    gpu_assisted_resynchronization = 1,
    best_practices = 2,
    debug_printf = 3,
    synchronize_validation = 4,
};

pub const ValidationFeatureDisableEXT = enum(i32) {
    shaders = 0,
    thread_safety = 1,
    api_parameters = 2,
    object_lifetimes = 3,
    core_checks = 4,
    unique_handles = 5,
    shader_validation_cache = 6,
};

// ============================================================================
// Structures
// ============================================================================

pub const ValidationFeaturesEXT = extern struct {
    s_type: types.StructureType = .validation_features_ext,
    p_next: ?*const anyopaque = null,
    enabled_validation_feature_count: u32 = 0,
    p_enabled_validation_features: [*]const ValidationFeatureEnableEXT = null,
    disabled_validation_feature_count: u32 = 0,
    p_disabled_validation_features: [*]const ValidationFeatureDisableEXT = null,
};

pub const PhysicalDeviceShaderObjectFeaturesEXT = extern struct {
    s_type: types.StructureType = .physical_device_shader_object_features_ext,
    p_next: ?*const anyopaque = null,
    shader_object_invoke: types.Bool32 = 0,
    shader_object_info: types.Bool32 = 0,
};

pub const ShaderObjectCreateInfoEXT = extern struct {
    s_type: types.StructureType = .shader_object_create_info_ext,
    p_next: ?*const anyopaque = null,
    shader_stage_count: u32 = 0,
    p_shader_stages: [*]const types.ShaderStageFlagBits = null,
    identifier_type: types.ShaderObjectIdentifierTypeEXT,
};

pub const ShaderObjectIdentifierTypeEXT = enum(i32) {
    binary_wide = 0,
    binary_opaque = 1,
};
