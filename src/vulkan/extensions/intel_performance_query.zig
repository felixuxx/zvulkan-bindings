//! VK_INTEL_performance_query extension
//! Intel-specific performance monitoring

const types = @import("../types.zig");

pub const INTEL_PERFORMANCE_QUERY_EXTENSION_NAME = "VK_INTEL_performance_query";

// ============================================================================
// Enums
// ============================================================================

pub const PerformanceConfigurationTypeINTEL = enum(i32) {
    command_queue_metrics_discovery_activated_intel = 0,
};

pub const PerformanceParameterTypeINTEL = enum(i32) {
    hw_counters_supported = 0,
    stream_marker_valid_bits_intel = 1,
};

pub const PerformanceOverrideTypeINTEL = enum(i32) {
    null_hardware_intel = 0,
    flush_gpu_caches_intel = 1,
    _,
};

pub const QueryPoolSamplingModeINTEL = enum(i32) {
    immediate = 0,
    continuous = 1,
};

pub const PerformanceValueTypeINTEL = enum(i32) {
    uint32 = 0,
    uint64 = 1,
    float = 2,
    bool_value = 3,
    string = 4,
};

// ============================================================================
// Structures
// ============================================================================

pub const InitializePerformanceApiInfoINTEL = extern struct {
    s_type: types.StructureType = .initialize_performance_api_info_intel,
    p_next: ?*const anyopaque = null,
    p_user_data: ?*anyopaque = null,
};

pub const QueryPoolPerformanceQueryCreateInfoINTEL = extern struct {
    s_type: types.StructureType = .query_pool_performance_query_create_info_intel,
    p_next: ?*const anyopaque = null,
    performance_counters_sampling: QueryPoolSamplingModeINTEL,
};

pub const QueryPoolCreateInfoINTEL = QueryPoolPerformanceQueryCreateInfoINTEL;

pub const PerformanceMarkerInfoINTEL = extern struct {
    s_type: types.StructureType = .performance_marker_info_intel,
    p_next: ?*const anyopaque = null,
    marker: u64,
};

pub const PerformanceOverrideInfoINTEL = extern struct {
    s_type: types.StructureType = .performance_override_info_intel,
    p_next: ?*const anyopaque = null,
    type: PerformanceOverrideTypeINTEL,
    enable: types.Bool32,
    parameter: u64,
};

pub const PerformanceStreamMarkerInfoINTEL = extern struct {
    s_type: types.StructureType = .performance_stream_marker_info_intel,
    p_next: ?*const anyopaque = null,
    marker: u32,
};

pub const PerformanceConfigurationINTEL = u64;

pub const PerformanceConfigurationAcquireInfoINTEL = extern struct {
    s_type: types.StructureType = .performance_configuration_acquire_info_intel,
    p_next: ?*const anyopaque = null,
    type: PerformanceConfigurationTypeINTEL,
};

pub const PerformanceValueDataINTEL = extern union {
    value32: u32,
    value64: u64,
    value_float: f32,
    value_bool: types.Bool32,
    value_string: [*:0]const u8,
};

pub const PerformanceValueINTEL = extern struct {
    type: PerformanceValueTypeINTEL,
    data: PerformanceValueDataINTEL,
};
