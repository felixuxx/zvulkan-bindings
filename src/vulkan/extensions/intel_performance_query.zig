//! VK_INTEL_performance_query extension
//! Intel-specific performance monitoring

const constants = @import("../constants.zig");
const types = @import("../types.zig");

pub const INTEL_PERFORMANCE_QUERY_EXTENSION_NAME = "VK_INTEL_performance_query";

// ============================================================================
// Enums
// ============================================================================

pub const PerformanceConfigurationTypeINTEL = enum(i32) {
    global_settings_queue_families = 0,
    global_settings_command_buffers = 1,
};

pub const PerformanceParameterTypeINTEL = enum(i32) {
    hw_counters_supported = 0,
    stream_marker_supported = 1,
};

pub const QueryPoolSamplingModeINTEL = enum(i32) {
    immediate = 0,
    continuous = 1,
};

pub const PerformanceValueTypeINTEL = enum(i32) {
    uint32 = 0,
    uint64 = 1,
    float32 = 2,
    float64 = 3,
    bool32 = 4,
    bool64 = 5,
};

pub const QueryHandleTypeINTEL = enum(i32) {
    performance_query_handle_type = 0,
};

// ============================================================================
// Structures
// ============================================================================

pub const InitializePerformanceApiInfoINTEL = extern struct {
    s_type: types.StructureType = .initialize_performance_api_info_intel,
    p_next: ?*const anyopaque = null,
};

pub const QueryPoolPerformanceCreateInfoINTEL = extern struct {
    s_type: types.StructureType = .query_pool_performance_create_info_intel,
    p_next: ?*const anyopaque = null,
    performance_query_type: PerformanceParameterTypeINTEL,
    queue_families: u32 = 0,
    p_queue_family_indices: ?[*]const u32 = null,
};

pub const PerformanceQueryInfoINTEL = extern struct {
    s_type: types.StructureType = .performance_query_info_intel,
    p_next: ?*const anyopaque = null,
    performance_counter_sampling: QueryPoolSamplingModeINTEL = .immediate,
};

pub const PerformanceMarkerInfoINTEL = extern struct {
    s_type: types.StructureType = .performance_marker_info_intel,
    p_next: ?*const anyopaque = null,
    marker: u64 = 0,
};

pub const PerformanceOverrideInfoINTEL = extern struct {
    s_type: types.StructureType = .performance_override_info_intel,
    p_next: ?*const anyopaque = null,
    type: PerformanceConfigurationTypeINTEL = .global_settings_command_buffers,
    enable: u32 = 0,
    data: u64 = 0,
};

pub const PerformanceStreamMarkerInfoINTEL = extern struct {
    s_type: types.StructureType = .performance_stream_marker_info_intel,
    p_next: ?*const anyopaque = null,
    marker: u64 = 0,
    data: u64 = 0,
};

pub const PerformanceConfigurationINTEL = extern struct {
    s_type: types.StructureType = .performance_configuration_intel,
    p_next: ?*const anyopaque = null,
    type: PerformanceConfigurationTypeINTEL,
    data: u64 = 0,
    enable: u32 = 0,
};

pub const QueryPoolPerformanceQueryCreateInfoINTEL = extern struct {
    s_type: types.StructureType = .query_pool_performance_query_create_info_intel,
    p_next: ?*const anyopaque = null,
    query: u32 = 0,
};

pub const PerformanceConfigurationAcquireInfoINTEL = extern struct {
    s_type: types.StructureType = .performance_configuration_acquire_info_intel,
    p_next: ?*const anyopaque = null,
    type: PerformanceConfigurationTypeINTEL,
};

pub const PerformanceValueINTEL = extern struct {
    type: PerformanceValueTypeINTEL,
    value: extern union {
        value32: u32,
        value64: u64,
        value_float: f32,
        value_float64: f64,
        value_bool: types.Bool32,
        value_bool64: u64,
        value_string: [*:0]const u8,
    },
};
