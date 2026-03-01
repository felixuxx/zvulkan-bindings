//! VK_EXT_validation_features extension
//! Validation layer controls

const types = @import("../types.zig");

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
    p_enabled_validation_features: ?[*]const ValidationFeatureEnableEXT = null,
    disabled_validation_feature_count: u32 = 0,
    p_disabled_validation_features: ?[*]const ValidationFeatureDisableEXT = null,
};
