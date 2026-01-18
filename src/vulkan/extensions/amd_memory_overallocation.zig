//! VK_AMD_memory_overallocation_behavior extension
//! AMD-specific memory overallocation handling

const types = @import("../types.zig");
const constants = @import("../constants.zig");

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
    allocation_size: types.DeviceSize,
    overallocation_behavior: MemoryOverallocationBehaviorAMD = .default_amd,
};

pub const PhysicalDeviceMemoryOverallocationBehaviorsFeaturesAMD = extern struct {
    s_type: types.StructureType = .physical_device_memory_overallocation_behaviors_features_amd,
    p_next: ?*const anyopaque = null,
    allowed_amd: types.Bool32 = 0,
    disallowed_amd: types.Bool32 = 0,
    allowed_device_mask: u32 = 0,
    disallowed_device_mask: u32 = 0,
};
