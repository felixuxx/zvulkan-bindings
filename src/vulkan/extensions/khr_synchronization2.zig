//! VK_KHR_synchronization2 extension
//! Modern synchronization patterns for improved performance

const types = @import("../types.zig");
const constants = @import("../constants.zig");
const core_1_0 = @import("../core_1_0.zig");

pub const KHR_SYNCHRONIZATION_2_EXTENSION_NAME = "VK_KHR_synchronization2";

// ============================================================================
// Enums
// ============================================================================

pub const Synchronization2TypeKHR = enum(i32) {
    legacy_khr = 0,
    legacy_ext = 1,
};

pub const StageMask2 = types.PipelineStageFlags2;

pub const AccessMask2 = types.AccessFlags2;

pub const DependencyFlagsKHR = types.DependencyFlagsKHR;

// ============================================================================
// Structures
// ============================================================================

pub const MemoryBarrier2 = extern struct {
    s_type: types.StructureType = .memory_barrier_2_khr,
    p_next: ?*const anyopaque = null,
    src_stage_mask: StageMask2,
    src_access_mask: AccessMask2,
    dst_stage_mask: StageMask2,
    dst_access_mask: AccessMask2,
};

pub const BufferMemoryBarrier2 = extern struct {
    s_type: types.StructureType = .buffer_memory_barrier_2_khr,
    p_next: ?*const anyopaque = null,
    src_stage_mask: StageMask2,
    src_access_mask: AccessMask2,
    dst_stage_mask: StageMask2,
    dst_access_mask: AccessMask2,
    src_queue_family_index: u32,
    dst_queue_family_index: u32,
    buffer: types.Buffer,
    offset: types.DeviceSize,
    size: types.DeviceSize,
};

pub const ImageMemoryBarrier2 = extern struct {
    s_type: types.StructureType = .image_memory_barrier_2_khr,
    p_next: ?*const anyopaque = null,
    src_stage_mask: StageMask2,
    src_access_mask: AccessMask2,
    dst_stage_mask: StageMask2,
    dst_access_mask: AccessMask2,
    old_layout: types.ImageLayout,
    new_layout: types.ImageLayout,
    src_queue_family_index: u32,
    dst_queue_family_index: u32,
    image: types.Image,
    subresource_range: core_1_0.ImageSubresourceRange,
};

pub const DependencyInfo = extern struct {
    s_type: types.StructureType = .dependency_info,
    p_next: ?*const anyopaque = null,
    dependency_flags: DependencyFlagsKHR = .{},
    memory_barrier_count: u32 = 0,
    p_memory_barriers: ?[*]const MemoryBarrier2 = null,
    buffer_memory_barrier_count: u32 = 0,
    p_buffer_memory_barriers: ?[*]const BufferMemoryBarrier2 = null,
    image_memory_barrier_count: u32 = 0,
    p_image_memory_barriers: ?[*]const ImageMemoryBarrier2 = null,
};

pub const SubmitInfo2 = extern struct {
    s_type: types.StructureType = .submit_info_2_khr,
    p_next: ?*const anyopaque = null,
    wait_semaphore_info_count: u32 = 0,
    p_wait_semaphore_infos: ?[*]const SemaphoreSubmitInfo = null,
    command_buffer_info_count: u32 = 0,
    p_command_buffer_infos: ?[*]const CommandBufferSubmitInfo = null,
    signal_semaphore_info_count: u32 = 0,
    p_signal_semaphore_infos: ?[*]const SemaphoreSubmitInfo = null,
};

pub const SemaphoreSubmitInfo = extern struct {
    s_type: types.StructureType = .semaphore_submit_info,
    p_next: ?*const anyopaque = null,
    semaphore: types.Semaphore,
    value: u64 = 0,
    stage_mask: StageMask2 = .{},
    device_index: u32 = 0,
};

pub const CommandBufferSubmitInfo = extern struct {
    s_type: types.StructureType = .command_buffer_submit_info,
    p_next: ?*const anyopaque = null,
    command_buffer: types.CommandBuffer,
    device_mask: u32 = 0,
};

pub const PhysicalDeviceSynchronization2Features = extern struct {
    s_type: types.StructureType = .physical_device_synchronization_2_features,
    p_next: ?*const anyopaque = null,
    synchronization2: types.Bool32 = 0,
    vulkan_memory_model: types.Bool32 = 0,
    vulkan_memory_model_device_scope: types.Bool32 = 0,
    vulkan_memory_model_access_scope: types.Bool32 = 0,
    public: types.Bool32 = 0,
};

pub const PhysicalDeviceSynchronization2FeaturesKHR = PhysicalDeviceSynchronization2Features;
