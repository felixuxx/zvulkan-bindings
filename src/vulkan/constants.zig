//! Vulkan API constants and version macros

// API Version macros
pub const API_VERSION_1_0 = makeApiVersion(0, 1, 0, 0);
pub const API_VERSION_1_1 = makeApiVersion(0, 1, 1, 0);
pub const API_VERSION_1_2 = makeApiVersion(0, 1, 2, 0);
pub const API_VERSION_1_3 = makeApiVersion(0, 1, 3, 0);

pub const HEADER_VERSION = 296;
pub const HEADER_VERSION_COMPLETE = makeApiVersion(0, 1, 3, HEADER_VERSION);

pub inline fn makeApiVersion(variant: u32, major: u32, minor: u32, patch: u32) u32 {
    return (variant << 29) | (major << 22) | (minor << 12) | patch;
}

pub inline fn versionMajor(version: u32) u32 {
    return (version >> 22) & 0x7F;
}

pub inline fn versionMinor(version: u32) u32 {
    return (version >> 12) & 0x3FF;
}

pub inline fn versionPatch(version: u32) u32 {
    return version & 0xFFF;
}

// Special constants
pub const TRUE: u32 = 1;
pub const FALSE: u32 = 0;

pub const NULL_HANDLE: u64 = 0;

pub const WHOLE_SIZE: u64 = ~@as(u64, 0);
pub const ATTACHMENT_UNUSED: u32 = ~@as(u32, 0);
pub const QUEUE_FAMILY_IGNORED: u32 = ~@as(u32, 0);
pub const QUEUE_FAMILY_EXTERNAL: u32 = ~@as(u32, 0) - 1;
pub const QUEUE_FAMILY_FOREIGN_EXT: u32 = ~@as(u32, 0) - 2;
pub const SUBPASS_EXTERNAL: u32 = ~@as(u32, 0);
pub const REMAINING_MIP_LEVELS: u32 = ~@as(u32, 0);
pub const REMAINING_ARRAY_LAYERS: u32 = ~@as(u32, 0);
pub const REMAINING_3D_SLICES_EXT: u32 = ~@as(u32, 0);

pub const LOD_CLAMP_NONE: f32 = 1000.0;

// Array sizes
pub const MAX_PHYSICAL_DEVICE_NAME_SIZE: u32 = 256;
pub const MAX_DEVICE_GROUP_SIZE = 32;
pub const UUID_SIZE: u32 = 16;
pub const LUID_SIZE: u32 = 8;
pub const MAX_EXTENSION_NAME_SIZE: u32 = 256;
pub const MAX_DESCRIPTION_SIZE: u32 = 256;
pub const MAX_MEMORY_TYPES: u32 = 32;
pub const MAX_MEMORY_HEAPS: u32 = 16;
pub const MAX_DRIVER_NAME_SIZE: u32 = 256;
pub const MAX_DRIVER_INFO_SIZE: u32 = 256;
