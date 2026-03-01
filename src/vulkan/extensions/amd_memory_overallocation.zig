//! VK_AMD_memory_overallocation_behavior extension
//! AMD-specific memory overallocation handling

const types = @import("../types.zig");

pub const AMD_MEMORY_OVERALLOCATION_BEHAVIOR_EXTENSION_NAME = "VK_AMD_memory_overallocation_behavior";

// ============================================================================
// Enums
// ============================================================================

pub const MemoryOverallocationBehaviorAMD = enum(i32) {
    default_amd = 0,
    allowed_amd = 1,
    disallowed_amd = 2,
};

// ============================================================================
// Structures
// ============================================================================

pub const DeviceMemoryOverallocationCreateInfoAMD = extern struct {
    s_type: types.StructureType = .device_memory_overallocation_create_info_amd,
    p_next: ?*const anyopaque = null,
    overallocation_behavior: MemoryOverallocationBehaviorAMD = .default_amd,
};
