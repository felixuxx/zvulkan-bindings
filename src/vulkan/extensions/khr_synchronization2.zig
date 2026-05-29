//! VK_KHR_synchronization2 extension
//! Modern synchronization patterns for improved performance

const types = @import("../types.zig");
const core_1_3 = @import("../core_1_3.zig");

pub const KHR_SYNCHRONIZATION_2_EXTENSION_NAME = "VK_KHR_synchronization2";

pub const StageMask2 = types.PipelineStageFlags2;

pub const AccessMask2 = types.AccessFlags2;

pub const DependencyFlagsKHR = types.DependencyFlags;

// == Structures (re-exported from core_1_3) ==

pub const MemoryBarrier2 = core_1_3.MemoryBarrier2;
pub const BufferMemoryBarrier2 = core_1_3.BufferMemoryBarrier2;
pub const ImageMemoryBarrier2 = core_1_3.ImageMemoryBarrier2;
pub const DependencyInfo = core_1_3.DependencyInfo;
pub const SubmitInfo2 = core_1_3.SubmitInfo2;
pub const SemaphoreSubmitInfo = core_1_3.SemaphoreSubmitInfo;
pub const CommandBufferSubmitInfo = core_1_3.CommandBufferSubmitInfo;
pub const PhysicalDeviceSynchronization2Features = core_1_3.PhysicalDeviceSynchronization2Features;

pub const PhysicalDeviceSynchronization2FeaturesKHR = PhysicalDeviceSynchronization2Features;
