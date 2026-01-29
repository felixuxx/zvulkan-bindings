//! Main Vulkan bindings entry point
//! Provides dynamic loading and function pointer dispatch for Vulkan API

const std = @import("std");

pub const constants = @import("constants.zig");
pub const core_1_0 = @import("core_1_0.zig");
pub const core_1_1 = @import("core_1_1.zig");
pub const core_1_2 = @import("core_1_2.zig");
pub const core_1_3 = @import("core_1_3.zig");
pub const core_1_4 = @import("core_1_4.zig");
pub const extensions = @import("extensions.zig");
pub const khr_surface = extensions.khr_surface;
pub const khr_swapchain = extensions.khr_swapchain;
pub const khr_wayland_surface = extensions.khr_wayland_surface;
pub const khr_xcb_surface = extensions.khr_xcb_surface;
pub const khr_xlib_surface = extensions.khr_xlib_surface;
pub const khr_win32_surface = extensions.khr_win32_surface;
pub const khr_dynamic_rendering = extensions.khr_dynamic_rendering;
pub const khr_synchronization2 = extensions.khr_synchronization2;
pub const khr_push_descriptor = extensions.khr_push_descriptor;
pub const khr_descriptor_update_template = extensions.khr_descriptor_update_template;
pub const khr_fragment_shading_rate = extensions.khr_fragment_shading_rate;
pub const ext_mesh_shader = extensions.ext_mesh_shader;
pub const ext_validation_features = extensions.ext_validation_features;
pub const amd_memory_overallocation = extensions.amd_memory_overallocation;
pub const intel_performance_query = extensions.intel_performance_query;
const platform = @import("platform.zig");
pub const types = @import("types.zig");
pub const Instance = types.Instance;
pub const PhysicalDevice = types.PhysicalDevice;
pub const Device = types.Device;
pub const Queue = types.Queue;
pub const CommandBuffer = types.CommandBuffer;
pub const Result = types.Result;

// Keep these for internal use and legacy compatibility if needed,
// OR switch internal usage to use 'extensions.khr_surface' etc.
// For now, aliasing them to the new extensions module is cleaner.
// Re-export commonly used types
// Re-export new extension types
// ============================================================================
// Function Pointer Types
// ============================================================================

pub const PFN_vkVoidFunction = ?*const fn () callconv(.c) void;
pub const PFN_vkGetInstanceProcAddr = *const fn (Instance, [*:0]const u8) callconv(.c) PFN_vkVoidFunction;
pub const PFN_vkGetDeviceProcAddr = *const fn (Device, [*:0]const u8) callconv(.c) PFN_vkVoidFunction;

// Global functions
pub const PFN_vkEnumerateInstanceVersion = *const fn (*u32) callconv(.c) Result;
pub const PFN_vkEnumerateInstanceExtensionProperties = *const fn (?[*:0]const u8, *u32, ?[*]ExtensionProperties) callconv(.c) Result;
pub const PFN_vkEnumerateInstanceLayerProperties = *const fn (*u32, ?[*]LayerProperties) callconv(.c) Result;
pub const PFN_vkCreateInstance = *const fn (*const core_1_0.InstanceCreateInfo, ?*const types.AllocationCallbacks, *Instance) callconv(.c) Result;

// Vulkan 1.1 Global
pub const PFN_vkEnumerateInstanceVersion_1_1 = *const fn (*u32) callconv(.c) Result; // Same signature, mostly for completeness checking

// Instance functions
pub const PFN_vkDestroyInstance = *const fn (Instance, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkEnumeratePhysicalDevices = *const fn (Instance, *u32, ?[*]PhysicalDevice) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceProperties = *const fn (PhysicalDevice, *core_1_0.PhysicalDeviceProperties) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceFeatures = *const fn (PhysicalDevice, *core_1_0.PhysicalDeviceFeatures) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceMemoryProperties = *const fn (PhysicalDevice, *core_1_0.PhysicalDeviceMemoryProperties) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceQueueFamilyProperties = *const fn (PhysicalDevice, *u32, ?[*]core_1_0.QueueFamilyProperties) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceFormatProperties = *const fn (PhysicalDevice, types.Format, *core_1_0.FormatProperties) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceImageFormatProperties = *const fn (PhysicalDevice, types.Format, types.ImageType, types.ImageTiling, types.ImageUsageFlags, types.ImageCreateFlags, *core_1_0.ImageFormatProperties) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceSparseImageFormatProperties = *const fn (PhysicalDevice, types.Format, types.ImageType, u32, types.ImageUsageFlags, types.ImageTiling, *u32, ?[*]core_1_0.SparseImageFormatProperties) callconv(.c) void;
pub const PFN_vkCreateDevice = *const fn (PhysicalDevice, *const core_1_0.DeviceCreateInfo, ?*const types.AllocationCallbacks, *Device) callconv(.c) Result;

// Vulkan 1.1 Instance
pub const PFN_vkEnumeratePhysicalDeviceGroups = *const fn (Instance, *u32, ?[*]core_1_1.PhysicalDeviceGroupProperties) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceFeatures2 = *const fn (PhysicalDevice, *core_1_1.PhysicalDeviceFeatures2) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceProperties2 = *const fn (PhysicalDevice, *core_1_1.PhysicalDeviceProperties2) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceFormatProperties2 = *const fn (PhysicalDevice, types.Format, *core_1_1.FormatProperties2) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceImageFormatProperties2 = *const fn (PhysicalDevice, *const core_1_1.PhysicalDeviceImageFormatInfo2, *core_1_1.ImageFormatProperties2) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceQueueFamilyProperties2 = *const fn (PhysicalDevice, *u32, ?[*]core_1_1.QueueFamilyProperties2) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceMemoryProperties2 = *const fn (PhysicalDevice, *core_1_1.PhysicalDeviceMemoryProperties2) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceSparseImageFormatProperties2 = *const fn (PhysicalDevice, *const core_1_1.PhysicalDeviceSparseImageFormatInfo2, *u32, ?[*]core_1_1.SparseImageFormatProperties2) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceExternalBufferProperties = *const fn (PhysicalDevice, *const core_1_1.PhysicalDeviceExternalBufferInfo, *core_1_1.ExternalBufferProperties) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceExternalFenceProperties = *const fn (PhysicalDevice, *const core_1_1.PhysicalDeviceExternalFenceInfo, *core_1_1.ExternalFenceProperties) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceExternalSemaphoreProperties = *const fn (PhysicalDevice, *const core_1_1.PhysicalDeviceExternalSemaphoreInfo, *core_1_1.ExternalSemaphoreProperties) callconv(.c) void;

// Vulkan 1.3 Instance
pub const PFN_vkGetPhysicalDeviceToolProperties = *const fn (PhysicalDevice, *u32, ?[*]core_1_3.PhysicalDeviceToolProperties) callconv(.c) Result;

// Device functions
pub const PFN_vkDestroyDevice = *const fn (Device, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkGetDeviceQueue = *const fn (Device, u32, u32, *Queue) callconv(.c) void;
pub const PFN_vkDeviceWaitIdle = *const fn (Device) callconv(.c) Result;
pub const PFN_vkQueueWaitIdle = *const fn (Queue) callconv(.c) Result;
pub const PFN_vkQueueSubmit = *const fn (Queue, u32, [*]const core_1_0.SubmitInfo, types.Fence) callconv(.c) Result;

// Memory functions
pub const PFN_vkAllocateMemory = *const fn (Device, *const core_1_0.MemoryAllocateInfo, ?*const types.AllocationCallbacks, *types.DeviceMemory) callconv(.c) Result;
pub const PFN_vkFreeMemory = *const fn (Device, types.DeviceMemory, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkMapMemory = *const fn (Device, types.DeviceMemory, types.DeviceSize, types.DeviceSize, u32, *?*anyopaque) callconv(.c) Result;
pub const PFN_vkUnmapMemory = *const fn (Device, types.DeviceMemory) callconv(.c) void;
pub const PFN_vkFlushMappedMemoryRanges = *const fn (Device, u32, [*]const core_1_0.MappedMemoryRange) callconv(.c) Result;
pub const PFN_vkInvalidateMappedMemoryRanges = *const fn (Device, u32, [*]const core_1_0.MappedMemoryRange) callconv(.c) Result;
pub const PFN_vkGetDeviceMemoryCommitment = *const fn (Device, types.DeviceMemory, *types.DeviceSize) callconv(.c) void;

// Buffer functions
pub const PFN_vkCreateBuffer = *const fn (Device, *const core_1_0.BufferCreateInfo, ?*const types.AllocationCallbacks, *types.Buffer) callconv(.c) Result;
pub const PFN_vkDestroyBuffer = *const fn (Device, types.Buffer, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkGetBufferMemoryRequirements = *const fn (Device, types.Buffer, *types.MemoryRequirements) callconv(.c) void;
pub const PFN_vkBindBufferMemory = *const fn (Device, types.Buffer, types.DeviceMemory, types.DeviceSize) callconv(.c) Result;
pub const PFN_vkCreateBufferView = *const fn (Device, *const core_1_0.BufferViewCreateInfo, ?*const types.AllocationCallbacks, *types.BufferView) callconv(.c) Result;
pub const PFN_vkDestroyBufferView = *const fn (Device, types.BufferView, ?*const types.AllocationCallbacks) callconv(.c) void;

// Image functions
pub const PFN_vkCreateImage = *const fn (Device, *const core_1_0.ImageCreateInfo, ?*const types.AllocationCallbacks, *types.Image) callconv(.c) Result;
pub const PFN_vkDestroyImage = *const fn (Device, types.Image, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkGetImageMemoryRequirements = *const fn (Device, types.Image, *types.MemoryRequirements) callconv(.c) void;
pub const PFN_vkBindImageMemory = *const fn (Device, types.Image, types.DeviceMemory, types.DeviceSize) callconv(.c) Result;
pub const PFN_vkGetImageSubresourceLayout = *const fn (Device, types.Image, *const types.ImageSubresource, *types.SubresourceLayout) callconv(.c) void;
pub const PFN_vkCreateImageView = *const fn (Device, *const core_1_0.ImageViewCreateInfo, ?*const types.AllocationCallbacks, *types.ImageView) callconv(.c) Result;
pub const PFN_vkDestroyImageView = *const fn (Device, types.ImageView, ?*const types.AllocationCallbacks) callconv(.c) void;

// Command buffer functions
pub const PFN_vkCreateCommandPool = *const fn (Device, *const core_1_0.CommandPoolCreateInfo, ?*const types.AllocationCallbacks, *types.CommandPool) callconv(.c) Result;
pub const PFN_vkDestroyCommandPool = *const fn (Device, types.CommandPool, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkAllocateCommandBuffers = *const fn (Device, *const core_1_0.CommandBufferAllocateInfo, [*]CommandBuffer) callconv(.c) Result;
pub const PFN_vkFreeCommandBuffers = *const fn (Device, types.CommandPool, u32, [*]const CommandBuffer) callconv(.c) void;
pub const PFN_vkBeginCommandBuffer = *const fn (CommandBuffer, *const core_1_0.CommandBufferBeginInfo) callconv(.c) Result;
pub const PFN_vkEndCommandBuffer = *const fn (CommandBuffer) callconv(.c) Result;
pub const PFN_vkResetCommandBuffer = *const fn (CommandBuffer, u32) callconv(.c) Result;
pub const PFN_vkCmdExecuteCommands = *const fn (CommandBuffer, u32, [*]const CommandBuffer) callconv(.c) void;

// Synchronization functions
pub const PFN_vkCreateFence = *const fn (Device, *const core_1_0.FenceCreateInfo, ?*const types.AllocationCallbacks, *types.Fence) callconv(.c) Result;
pub const PFN_vkDestroyFence = *const fn (Device, types.Fence, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkGetFenceStatus = *const fn (Device, types.Fence) callconv(.c) Result;
pub const PFN_vkWaitForFences = *const fn (Device, u32, [*]const types.Fence, types.Bool32, u64) callconv(.c) Result;
pub const PFN_vkResetFences = *const fn (Device, u32, [*]const types.Fence) callconv(.c) Result;
pub const PFN_vkCreateSemaphore = *const fn (Device, *const core_1_0.SemaphoreCreateInfo, ?*const types.AllocationCallbacks, *types.Semaphore) callconv(.c) Result;
pub const PFN_vkDestroySemaphore = *const fn (Device, types.Semaphore, ?*const types.AllocationCallbacks) callconv(.c) void;

// Shader and pipeline functions
pub const PFN_vkCreateShaderModule = *const fn (Device, *const core_1_0.ShaderModuleCreateInfo, ?*const types.AllocationCallbacks, *types.ShaderModule) callconv(.c) Result;
pub const PFN_vkDestroyShaderModule = *const fn (Device, types.ShaderModule, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkCreatePipelineLayout = *const fn (Device, *const core_1_0.PipelineLayoutCreateInfo, ?*const types.AllocationCallbacks, *types.PipelineLayout) callconv(.c) Result;
pub const PFN_vkDestroyPipelineLayout = *const fn (Device, types.PipelineLayout, ?*const types.AllocationCallbacks) callconv(.c) void;

// Graphics pipeline functions
pub const PFN_vkCreateGraphicsPipelines = *const fn (Device, types.PipelineCache, u32, [*]const core_1_0.GraphicsPipelineCreateInfo, ?*const types.AllocationCallbacks, [*]types.Pipeline) callconv(.c) Result;
pub const PFN_vkCreateComputePipelines = *const fn (Device, types.PipelineCache, u32, [*]const core_1_0.ComputePipelineCreateInfo, ?*const types.AllocationCallbacks, [*]types.Pipeline) callconv(.c) Result;
pub const PFN_vkDestroyPipeline = *const fn (Device, types.Pipeline, ?*const types.AllocationCallbacks) callconv(.c) void;

// Timeline semaphore functions
pub const PFN_vkCreateSemaphoreWithTypesKHR = *const fn (Device, [*]const core_1_2.SemaphoreTypeCreateInfo, ?*const types.AllocationCallbacks, *types.Semaphore) callconv(.c) Result;

// Pipeline cache management
pub const PFN_vkCreatePipelineCache = *const fn (Device, [*]const core_1_0.PipelineCacheCreateInfo, ?*const types.AllocationCallbacks, *types.PipelineCache) callconv(.c) Result;
pub const PFN_vkDestroyPipelineCache = *const fn (Device, types.PipelineCache, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkGetPipelineCacheData = *const fn (Device, types.PipelineCache, [*]u8, [*]usize) callconv(.c) Result;
pub const PFN_vkMergePipelineCaches = *const fn (Device, u32, [*]const types.PipelineCache, *types.PipelineCache, [*]u8) callconv(.c) Result;

// Descriptor management functions
pub const PFN_vkCreateDescriptorSetLayout = *const fn (Device, [*]const core_1_0.DescriptorSetLayoutCreateInfo, ?*const types.AllocationCallbacks, *types.DescriptorSetLayout) callconv(.c) Result;
pub const PFN_vkDestroyDescriptorSetLayout = *const fn (Device, types.DescriptorSetLayout, ?*const types.AllocationCallbacks) callconv(.c) void;

pub const PFN_vkCreateDescriptorPool = *const fn (Device, [*]const core_1_0.DescriptorPoolCreateInfo, ?*const types.AllocationCallbacks, *types.DescriptorPool) callconv(.c) Result;
pub const PFN_vkDestroyDescriptorPool = *const fn (Device, types.DescriptorPool, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkResetDescriptorPool = *const fn (Device, types.DescriptorPool, u32) callconv(.c) Result;

pub const PFN_vkAllocateDescriptorSets = *const fn (Device, [*]const core_1_0.DescriptorSetAllocateInfo, ?*const types.AllocationCallbacks, [*]types.DescriptorSet) callconv(.c) Result;

pub const PFN_vkFreeDescriptorSets = *const fn (Device, u32, [*]types.DescriptorSet, ?*const types.AllocationCallbacks) callconv(.c) void;

pub const PFN_vkUpdateDescriptorSets = *const fn (Device, u32, [*]const core_1_0.WriteDescriptorSet, u32, [*]const core_1_0.CopyDescriptorSet) callconv(.c) void;

pub const PFN_vkCreateSampler = *const fn (Device, [*]const core_1_0.SamplerCreateInfo, ?*const types.AllocationCallbacks, *types.Sampler) callconv(.c) Result;
pub const PFN_vkDestroySampler = *const fn (Device, types.Sampler, ?*const types.AllocationCallbacks) callconv(.c) void;

// Command buffer functions
pub const PFN_vkCreateQueryPool = *const fn (Device, [*]const core_1_0.QueryPoolCreateInfo, ?*const types.AllocationCallbacks, *types.QueryPool) callconv(.c) Result;
pub const PFN_vkDestroyQueryPool = *const fn (Device, types.QueryPool, ?*const types.AllocationCallbacks) callconv(.c) void;

pub const PFN_vkCreateEvent = *const fn (Device, [*]const core_1_0.EventCreateInfo, ?*const types.AllocationCallbacks, *types.Event) callconv(.c) Result;
pub const PFN_vkDestroyEvent = *const fn (Device, types.Event, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkGetEventStatus = *const fn (Device, types.Event) callconv(.c) Result;
pub const PFN_vkSetEvent = *const fn (Device, types.Event) callconv(.c) Result;
pub const PFN_vkResetEvent = *const fn (Device, types.Event) callconv(.c) Result;

pub const PFN_vkCmdPipelineBarrier = *const fn (types.CommandBuffer, types.PipelineStageFlags, types.PipelineStageFlags, types.DependencyFlags, u32, [*]const core_1_0.MemoryBarrier, u32, [*]const core_1_0.BufferMemoryBarrier, u32, [*]const core_1_0.ImageMemoryBarrier) callconv(.c) void;

// Copy functions
pub const PFN_vkCmdCopyBuffer = *const fn (types.CommandBuffer, types.Buffer, types.Buffer, [*]const core_1_0.BufferCopy) callconv(.c) void;
pub const PFN_vkCmdCopyImage = *const fn (types.CommandBuffer, types.Image, types.Image, [*]const core_1_0.ImageCopy) callconv(.c) void;
pub const PFN_vkCmdBlitImage = *const fn (types.CommandBuffer, types.Image, types.Image, [*]const core_1_0.ImageBlit) callconv(.c) void;
pub const PFN_vkCmdClearAttachments = *const fn (types.CommandBuffer, u32, [*]const core_1_0.ClearAttachment, types.Rect2D, u32) callconv(.c) void;

// Render pass functions
pub const PFN_vkCreateRenderPass = *const fn (Device, *const core_1_0.RenderPassCreateInfo, ?*const types.AllocationCallbacks, *types.RenderPass) callconv(.c) Result;
pub const PFN_vkDestroyRenderPass = *const fn (Device, types.RenderPass, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkCreateFramebuffer = *const fn (Device, *const core_1_0.FramebufferCreateInfo, ?*const types.AllocationCallbacks, *types.Framebuffer) callconv(.c) Result;
pub const PFN_vkDestroyFramebuffer = *const fn (Device, types.Framebuffer, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkCmdBeginRenderPass = *const fn (CommandBuffer, *const core_1_0.RenderPassBeginInfo, types.SubpassContents) callconv(.c) void;
pub const PFN_vkCmdNextSubpass = *const fn (CommandBuffer, types.SubpassContents) callconv(.c) void;
pub const PFN_vkCmdEndRenderPass = *const fn (CommandBuffer) callconv(.c) void;

// Vulkan 1.1 Device
pub const PFN_vkBindBufferMemory2 = *const fn (Device, u32, [*]const core_1_1.BindBufferMemoryInfo) callconv(.c) Result;
pub const PFN_vkBindImageMemory2 = *const fn (Device, u32, [*]const core_1_1.BindImageMemoryInfo) callconv(.c) Result;
pub const PFN_vkGetDeviceGroupPeerMemoryFeatures = *const fn (Device, u32, u32, u32, *types.PeerMemoryFeatureFlags) callconv(.c) void;
pub const PFN_vkCmdSetDeviceMask = *const fn (CommandBuffer, u32) callconv(.c) void;
pub const PFN_vkCmdDispatchBase = *const fn (CommandBuffer, u32, u32, u32, u32, u32, u32) callconv(.c) void;
pub const PFN_vkGetImageMemoryRequirements2 = *const fn (Device, *const types.ImageMemoryRequirementsInfo2, *types.MemoryRequirements2) callconv(.c) void;
pub const PFN_vkGetBufferMemoryRequirements2 = *const fn (Device, *const types.BufferMemoryRequirementsInfo2, *types.MemoryRequirements2) callconv(.c) void;
pub const PFN_vkGetDeviceQueue2 = *const fn (Device, *const types.DeviceQueueInfo2, *Queue) callconv(.c) void;
pub const PFN_vkTrimCommandPool = *const fn (Device, types.CommandPool, types.CommandPoolTrimFlags) callconv(.c) void;
pub const PFN_vkResetCommandPool = *const fn (Device, types.CommandPool, types.CommandPoolResetFlags) callconv(.c) Result;

// Vulkan 1.2 Device
pub const PFN_vkCmdDrawIndirectCount = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, types.Buffer, types.DeviceSize, u32, u32) callconv(.c) void;
pub const PFN_vkCmdDrawIndexedIndirectCount = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, types.Buffer, types.DeviceSize, u32, u32) callconv(.c) void;
pub const PFN_vkCreateRenderPass2 = *const fn (Device, *const types.RenderPassCreateInfo2, ?*const types.AllocationCallbacks, *types.RenderPass) callconv(.c) Result;
pub const PFN_vkCmdBeginRenderPass2 = *const fn (CommandBuffer, *const types.RenderPassBeginInfo, *const types.SubpassBeginInfo) callconv(.c) void;
pub const PFN_vkCmdNextSubpass2 = *const fn (CommandBuffer, *const types.SubpassBeginInfo, *const types.SubpassEndInfo) callconv(.c) void;
pub const PFN_vkCmdEndRenderPass2 = *const fn (CommandBuffer, *const types.SubpassEndInfo) callconv(.c) void;
pub const PFN_vkResetQueryPool = *const fn (Device, types.QueryPool, u32, u32) callconv(.c) void;
pub const PFN_vkGetSemaphoreCounterValue = *const fn (Device, types.Semaphore, *u64) callconv(.c) Result;
pub const PFN_vkWaitSemaphores = *const fn (Device, *const core_1_2.SemaphoreWaitInfo, u64) callconv(.c) Result;
pub const PFN_vkSignalSemaphore = *const fn (Device, *const core_1_2.SemaphoreSignalInfo) callconv(.c) Result;
pub const PFN_vkGetBufferDeviceAddress = *const fn (Device, *const core_1_2.BufferDeviceAddressInfo) callconv(.c) types.DeviceAddress;
pub const PFN_vkGetBufferOpaqueCaptureAddress = *const fn (Device, *const core_1_2.BufferDeviceAddressInfo) callconv(.c) u64;
pub const PFN_vkGetDeviceMemoryOpaqueCaptureAddress = *const fn (Device, *const core_1_2.DeviceMemoryOpaqueCaptureAddressInfo) callconv(.c) u64;

// Vulkan 1.3 Device
pub const PFN_vkCreatePrivateDataSlot = *const fn (Device, *const types.PrivateDataSlotCreateInfo, ?*const types.AllocationCallbacks, *types.PrivateDataSlot) callconv(.c) Result;
pub const PFN_vkDestroyPrivateDataSlot = *const fn (Device, types.PrivateDataSlot, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkSetPrivateData = *const fn (Device, types.ObjectType, u64, types.PrivateDataSlot, u64) callconv(.c) Result;
pub const PFN_vkGetPrivateData = *const fn (Device, types.ObjectType, u64, types.PrivateDataSlot, *u64) callconv(.c) void;
pub const PFN_vkCmdSetEvent2 = *const fn (CommandBuffer, types.Event, *const core_1_3.DependencyInfo) callconv(.c) void;
pub const PFN_vkCmdResetEvent2 = *const fn (CommandBuffer, types.Event, types.PipelineStageFlags2) callconv(.c) void;
pub const PFN_vkCmdWaitEvents2 = *const fn (CommandBuffer, u32, [*]const types.Event, *const core_1_3.DependencyInfo) callconv(.c) void;
pub const PFN_vkCmdPipelineBarrier2 = *const fn (CommandBuffer, *const core_1_3.DependencyInfo) callconv(.c) void;
pub const PFN_vkQueueSubmit2 = *const fn (Queue, u32, [*]const types.SubmitInfo2, types.Fence) callconv(.c) Result;
pub const PFN_vkCmdWriteTimestamp2 = *const fn (CommandBuffer, types.PipelineStageFlags2, types.QueryPool, u32) callconv(.c) void;
pub const PFN_vkCmdCopyBuffer2 = *const fn (CommandBuffer, *const types.CopyBufferInfo2) callconv(.c) void;
pub const PFN_vkCmdCopyImage2 = *const fn (CommandBuffer, *const types.CopyImageInfo2) callconv(.c) void;
pub const PFN_vkCmdCopyBufferToImage2 = *const fn (CommandBuffer, *const types.CopyBufferToImageInfo2) callconv(.c) void;
pub const PFN_vkCmdCopyImageToBuffer2 = *const fn (CommandBuffer, *const types.CopyImageToBufferInfo2) callconv(.c) void;
pub const PFN_vkCmdBlitImage2 = *const fn (CommandBuffer, *const types.BlitImageInfo2) callconv(.c) void;
pub const PFN_vkCmdResolveImage2 = *const fn (CommandBuffer, *const types.ResolveImageInfo2) callconv(.c) void;
pub const PFN_vkCmdBeginRendering = *const fn (CommandBuffer, *const core_1_3.RenderingInfo) callconv(.c) void;
pub const PFN_vkCmdEndRendering = *const fn (CommandBuffer) callconv(.c) void;
pub const PFN_vkCmdSetCullMode = *const fn (CommandBuffer, types.CullModeFlags) callconv(.c) void;
pub const PFN_vkCmdSetFrontFace = *const fn (CommandBuffer, types.FrontFace) callconv(.c) void;
pub const PFN_vkCmdSetPrimitiveTopology = *const fn (CommandBuffer, types.PrimitiveTopology) callconv(.c) void;
pub const PFN_vkCmdSetViewportWithCount = *const fn (CommandBuffer, u32, [*]const types.Viewport) callconv(.c) void;
pub const PFN_vkCmdSetScissorWithCount = *const fn (CommandBuffer, u32, [*]const types.Rect2D) callconv(.c) void;
pub const PFN_vkCmdBindVertexBuffers2 = *const fn (CommandBuffer, u32, u32, [*]const types.Buffer, [*]const types.DeviceSize, ?[*]const types.DeviceSize, ?[*]const types.DeviceSize) callconv(.c) void;

// Vulkan 1.0 state setting functions
pub const PFN_vkCmdSetViewport = *const fn (CommandBuffer, u32, u32, [*]const types.Viewport) callconv(.c) void;
pub const PFN_vkCmdSetScissor = *const fn (CommandBuffer, u32, u32, [*]const types.Rect2D) callconv(.c) void;
pub const PFN_vkCmdSetLineWidth = *const fn (CommandBuffer, f32) callconv(.c) void;
pub const PFN_vkCmdSetDepthBias = *const fn (CommandBuffer, f32, f32, f32) callconv(.c) void;
pub const PFN_vkCmdSetBlendConstants = *const fn (CommandBuffer, f32, f32, f32, f32) callconv(.c) void;
pub const PFN_vkCmdSetDepthBounds = *const fn (CommandBuffer, f32, f32) callconv(.c) void;
pub const PFN_vkCmdSetStencilCompareMask = *const fn (CommandBuffer, types.StencilFaceFlags, u32) callconv(.c) void;
pub const PFN_vkCmdSetStencilWriteMask = *const fn (CommandBuffer, types.StencilFaceFlags, u32) callconv(.c) void;
pub const PFN_vkCmdSetStencilReference = *const fn (CommandBuffer, types.StencilFaceFlags, u32) callconv(.c) void;

// Command buffer binding function pointer types
pub const PFN_vkCmdBindPipeline = *const fn (CommandBuffer, types.PipelineBindPoint, types.Pipeline) callconv(.c) void;
pub const PFN_vkCmdBindDescriptorSets = *const fn (CommandBuffer, types.PipelineBindPoint, types.PipelineLayout, u32, u32, ?[*]const types.DescriptorSet, u32, ?[*]const u32) callconv(.c) void;
pub const PFN_vkCmdBindIndexBuffer = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, types.IndexType) callconv(.c) void;
pub const PFN_vkCmdBindVertexBuffers = *const fn (CommandBuffer, u32, u32, ?[*]const types.Buffer, ?[*]const types.DeviceSize) callconv(.c) void;
pub const PFN_vkCmdBindVertexBuffers2EXT = *const fn (CommandBuffer, u32, u32, ?[*]const types.Buffer, [*]const types.DeviceSize, ?[*]const types.DeviceSize, ?[*]const types.DeviceSize) callconv(.c) void;
pub const PFN_vkCmdBindShadingRateImageNV = *const fn (CommandBuffer, types.ImageView, types.ImageLayout) callconv(.c) void;
pub const PFN_vkCmdBindTransformFeedbackBuffersEXT = *const fn (CommandBuffer, u32, u32, ?[*]const types.Buffer, ?[*]const types.DeviceSize, ?[*]const types.DeviceSize) callconv(.c) void;

// Copy functions with correct signatures for DeviceDispatch
pub const PFN_vkCmdCopyBufferToImage = *const fn (CommandBuffer, types.Buffer, types.Image, types.ImageLayout, u32, [*]const core_1_0.BufferImageCopy) callconv(.c) void;
pub const PFN_vkCmdCopyImageToBuffer = *const fn (CommandBuffer, types.Image, types.ImageLayout, types.Buffer, u32, [*]const core_1_0.BufferImageCopy) callconv(.c) void;
pub const PFN_vkCmdFillBuffer = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, types.DeviceSize, u32) callconv(.c) void;
pub const PFN_vkCmdUpdateBuffer = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, types.DeviceSize, [*]const u8) callconv(.c) void;
pub const PFN_vkCmdResolveImage = *const fn (CommandBuffer, types.Image, types.ImageLayout, types.Image, types.ImageLayout, u32, [*]const core_1_0.ImageResolve) callconv(.c) void;

// Clear functions
pub const PFN_vkCmdClearColorImage = *const fn (CommandBuffer, types.Image, types.ImageLayout, [*]const types.ClearColorValue, u32, [*]const core_1_0.ImageSubresourceRange) callconv(.c) void;
pub const PFN_vkCmdClearDepthStencilImage = *const fn (CommandBuffer, types.Image, types.ImageLayout, [*]const types.ClearDepthStencilValue, u32, [*]const core_1_0.ImageSubresourceRange) callconv(.c) void;

// Query functions
pub const PFN_vkCmdBeginQuery = *const fn (CommandBuffer, types.QueryPool, u32, types.QueryControlFlags) callconv(.c) void;
pub const PFN_vkCmdEndQuery = *const fn (CommandBuffer, types.QueryPool, u32) callconv(.c) void;
pub const PFN_vkCmdResetQueryPool = *const fn (CommandBuffer, types.QueryPool, u32, u32) callconv(.c) void;
pub const PFN_vkCmdCopyQueryPoolResults = *const fn (CommandBuffer, types.QueryPool, u32, u32, types.Buffer, types.DeviceSize, types.DeviceSize, types.QueryResultFlags) callconv(.c) void;
pub const PFN_vkCmdWriteTimestamp = *const fn (CommandBuffer, types.PipelineStageFlagBits, types.QueryPool, u32) callconv(.c) void;

// Event synchronization functions
pub const PFN_vkCmdSetEvent = *const fn (CommandBuffer, types.Event, types.PipelineStageFlags) callconv(.c) void;
pub const PFN_vkCmdResetEvent = *const fn (CommandBuffer, types.Event, types.PipelineStageFlags) callconv(.c) void;
pub const PFN_vkCmdWaitEvents = *const fn (CommandBuffer, u32, [*]const types.Event, types.PipelineStageFlags, types.PipelineStageFlags, u32, [*]const core_1_0.MemoryBarrier, u32, [*]const core_1_0.BufferMemoryBarrier, u32, [*]const core_1_0.ImageMemoryBarrier) callconv(.c) void;

// Query management functions
pub const PFN_vkGetQueryPoolResults = *const fn (Device, types.QueryPool, u32, u32, types.DeviceSize, types.DeviceSize, types.QueryResultFlags) callconv(.c) Result;

// Mesh shader functions
pub const PFN_vkCmdDrawMeshTasksNV = *const fn (CommandBuffer, u32, u32) callconv(.c) void;
pub const PFN_vkCmdDrawMeshTasksIndirectNV = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, u32, u32) callconv(.c) void;
pub const PFN_vkCmdDrawMeshTasksIndirectCountNV = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, types.Buffer, types.DeviceSize, u32, u32) callconv(.c) void;
pub const PFN_vkCmdDrawMeshTasksEXT = *const fn (CommandBuffer, u32, u32, u32) callconv(.c) void;
pub const PFN_vkCmdDrawMeshTasksIndirectEXT = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, u32, u32) callconv(.c) void;
pub const PFN_vkCmdDrawMeshTasksIndirectCountEXT = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, types.Buffer, types.DeviceSize, u32, u32) callconv(.c) void;

// VK_KHR_push_descriptor
pub const PFN_vkCmdPushDescriptorSetKHR = *const fn (CommandBuffer, types.PipelineBindPoint, types.PipelineLayout, u32, u32, [*]const core_1_0.WriteDescriptorSet) callconv(.c) void;

// VK_KHR_descriptor_update_template
pub const PFN_vkCreateDescriptorUpdateTemplateKHR = *const fn (Device, *const khr_descriptor_update_template.DescriptorUpdateTemplateCreateInfoKHR, ?*const types.AllocationCallbacks, *types.DescriptorUpdateTemplateKHR) callconv(.c) Result;
pub const PFN_vkDestroyDescriptorUpdateTemplateKHR = *const fn (Device, types.DescriptorUpdateTemplateKHR, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkUpdateDescriptorSetWithTemplateKHR = *const fn (Device, types.DescriptorSet, types.DescriptorUpdateTemplateKHR, *const anyopaque) callconv(.c) void;

// VK_KHR_fragment_shading_rate
pub const PFN_vkCmdSetFragmentShadingRateKHR = *const fn (CommandBuffer, *const types.Extent2D, *const [2]khr_fragment_shading_rate.FragmentShadingRateCombinerOpKHR) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceFragmentShadingRatesKHR = *const fn (PhysicalDevice, *u32, ?[*]khr_fragment_shading_rate.PhysicalDeviceFragmentShadingRateKHR) callconv(.c) Result;

// VK_INTEL_performance_query
pub const PFN_vkInitializePerformanceApiINTEL = *const fn (Device, *const intel_performance_query.InitializePerformanceApiInfoINTEL) callconv(.c) Result;
pub const PFN_vkUninitializePerformanceApiINTEL = *const fn (Device) callconv(.c) void;
pub const PFN_vkCmdSetPerformanceMarkerINTEL = *const fn (CommandBuffer, *const intel_performance_query.PerformanceMarkerInfoINTEL) callconv(.c) Result;
pub const PFN_vkCmdSetPerformanceStreamMarkerINTEL = *const fn (CommandBuffer, *const intel_performance_query.PerformanceStreamMarkerInfoINTEL) callconv(.c) Result;
pub const PFN_vkCmdSetPerformanceOverrideINTEL = *const fn (CommandBuffer, *const intel_performance_query.PerformanceOverrideInfoINTEL) callconv(.c) Result;
pub const PFN_vkAcquirePerformanceConfigurationINTEL = *const fn (Device, *const intel_performance_query.PerformanceConfigurationAcquireInfoINTEL, *intel_performance_query.PerformanceConfigurationINTEL) callconv(.c) Result;
pub const PFN_vkReleasePerformanceConfigurationINTEL = *const fn (Device, intel_performance_query.PerformanceConfigurationINTEL) callconv(.c) Result;
pub const PFN_vkQueueSetPerformanceConfigurationINTEL = *const fn (Queue, intel_performance_query.PerformanceConfigurationINTEL) callconv(.c) Result;
pub const PFN_vkGetPerformanceParameterINTEL = *const fn (Device, intel_performance_query.PerformanceParameterTypeINTEL, *intel_performance_query.PerformanceValueINTEL) callconv(.c) Result;

// Core drawing functions
pub const PFN_vkCmdDraw = *const fn (CommandBuffer, u32, u32, u32, u32) callconv(.c) void;
pub const PFN_vkCmdDrawIndexed = *const fn (CommandBuffer, u32, u32, u32, u32, u32) callconv(.c) void;
pub const PFN_vkCmdDrawIndirect = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, u32, u32) callconv(.c) void;
pub const PFN_vkCmdDrawIndexedIndirect = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, u32, u32) callconv(.c) void;
pub const PFN_vkCmdPushConstants = *const fn (CommandBuffer, types.PipelineLayout, types.ShaderStageFlags, u32, u32, ?*const anyopaque) callconv(.c) void;
pub const PFN_vkCmdDispatch = *const fn (CommandBuffer, u32, u32, u32) callconv(.c) void;
pub const PFN_vkCmdDispatchIndirect = *const fn (CommandBuffer, types.Buffer, types.DeviceSize) callconv(.c) void;

// Dynamic state functions (from Vulkan 1.3)
pub const PFN_vkCmdSetDepthTestEnable = *const fn (CommandBuffer, types.Bool32) callconv(.c) void;
pub const PFN_vkCmdSetDepthWriteEnable = *const fn (CommandBuffer, types.Bool32) callconv(.c) void;
pub const PFN_vkCmdSetDepthCompareOp = *const fn (CommandBuffer, types.CompareOp) callconv(.c) void;
pub const PFN_vkCmdSetDepthBoundsTestEnable = *const fn (CommandBuffer, types.Bool32) callconv(.c) void;
pub const PFN_vkCmdSetStencilTestEnable = *const fn (CommandBuffer, types.Bool32) callconv(.c) void;
pub const PFN_vkCmdSetStencilOp = *const fn (CommandBuffer, types.StencilFaceFlags, types.StencilOp, types.StencilOp, types.StencilOp, types.CompareOp) callconv(.c) void;
pub const PFN_vkCmdSetRasterizerDiscardEnable = *const fn (CommandBuffer, types.Bool32) callconv(.c) void;
pub const PFN_vkCmdSetDepthBiasEnable = *const fn (CommandBuffer, types.Bool32) callconv(.c) void;
pub const PFN_vkCmdSetPrimitiveRestartEnable = *const fn (CommandBuffer, types.Bool32) callconv(.c) void;

// Vulkan 1.4 / Maintenance5 functions
pub const PFN_vkCmdBindIndexBuffer2KHR = *const fn (CommandBuffer, types.Buffer, types.DeviceSize, types.DeviceSize, types.IndexType) callconv(.c) void;
pub const PFN_vkGetDeviceImageSubresourceLayoutKHR = *const fn (Device, *const core_1_4.DeviceImageSubresourceInfoKHR, *core_1_4.SubresourceLayout2KHR) callconv(.c) void;
pub const PFN_vkGetImageSubresourceLayout2KHR = *const fn (Device, types.Image, *const core_1_4.ImageSubresource2KHR, *core_1_4.SubresourceLayout2KHR) callconv(.c) void;
pub const PFN_vkGetRenderingAreaGranularityKHR = *const fn (Device, *const core_1_4.RenderingAreaInfoKHR, *types.Extent2D) callconv(.c) void;

// ============================================================================
// Extension Function Types
// ============================================================================

// VK_KHR_surface
pub const PFN_vkDestroySurfaceKHR = *const fn (Instance, types.SurfaceKHR, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceSurfaceSupportKHR = *const fn (PhysicalDevice, u32, types.SurfaceKHR, *types.Bool32) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceSurfaceCapabilitiesKHR = *const fn (PhysicalDevice, types.SurfaceKHR, *khr_surface.SurfaceCapabilitiesKHR) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceSurfaceFormatsKHR = *const fn (PhysicalDevice, types.SurfaceKHR, *u32, ?[*]khr_surface.SurfaceFormatKHR) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceSurfacePresentModesKHR = *const fn (PhysicalDevice, types.SurfaceKHR, *u32, ?[*]khr_surface.PresentModeKHR) callconv(.c) Result;

// VK_KHR_swapchain
pub const PFN_vkCreateSwapchainKHR = *const fn (Device, *const khr_swapchain.SwapchainCreateInfoKHR, ?*const types.AllocationCallbacks, *types.SwapchainKHR) callconv(.c) Result;
pub const PFN_vkDestroySwapchainKHR = *const fn (Device, types.SwapchainKHR, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkGetSwapchainImagesKHR = *const fn (Device, types.SwapchainKHR, *u32, ?[*]types.Image) callconv(.c) Result;
pub const PFN_vkAcquireNextImageKHR = *const fn (Device, types.SwapchainKHR, u64, types.Semaphore, types.Fence, *u32) callconv(.c) Result;
pub const PFN_vkQueuePresentKHR = *const fn (Queue, *const khr_swapchain.PresentInfoKHR) callconv(.c) Result;

// VK_KHR_wayland_surface
pub const PFN_vkCreateWaylandSurfaceKHR = *const fn (Instance, *const khr_wayland_surface.WaylandSurfaceCreateInfoKHR, ?*const types.AllocationCallbacks, *types.SurfaceKHR) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceWaylandPresentationSupportKHR = *const fn (PhysicalDevice, u32, *khr_wayland_surface.wl_display) callconv(.c) types.Bool32;

// VK_KHR_xcb_surface
pub const PFN_vkCreateXcbSurfaceKHR = *const fn (Instance, *const khr_xcb_surface.XcbSurfaceCreateInfoKHR, ?*const types.AllocationCallbacks, *types.SurfaceKHR) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceXcbPresentationSupportKHR = *const fn (PhysicalDevice, u32, *khr_xcb_surface.xcb_connection_t, khr_xcb_surface.xcb_window_t) callconv(.c) types.Bool32;

// VK_KHR_xlib_surface
pub const PFN_vkCreateXlibSurfaceKHR = *const fn (Instance, *const khr_xlib_surface.XlibSurfaceCreateInfoKHR, ?*const types.AllocationCallbacks, *types.SurfaceKHR) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR = *const fn (PhysicalDevice, u32, *khr_xlib_surface.Display, khr_xlib_surface.Window) callconv(.c) types.Bool32;

// VK_KHR_win32_surface
pub const PFN_vkCreateWin32SurfaceKHR = *const fn (Instance, *const khr_win32_surface.Win32SurfaceCreateInfoKHR, ?*const types.AllocationCallbacks, *types.SurfaceKHR) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR = *const fn (PhysicalDevice, u32) callconv(.c) types.Bool32;

// ============================================================================
// Extension and Layer Structures
// ============================================================================

pub const ExtensionProperties = extern struct {
    extension_name: [constants.MAX_EXTENSION_NAME_SIZE]u8,
    spec_version: u32,
};

pub const LayerProperties = extern struct {
    layer_name: [constants.MAX_EXTENSION_NAME_SIZE]u8,
    spec_version: u32,
    implementation_version: u32,
    description: [constants.MAX_DESCRIPTION_SIZE]u8,
};

// ============================================================================
// Vulkan Loader
// ============================================================================

pub const LoaderError = error{
    FunctionNotAvailable,
    EnumerationFailed,
};

pub const Loader = struct {
    library_handle: platform.LibraryHandle,
    vkGetInstanceProcAddr: PFN_vkGetInstanceProcAddr,

    // Global functions
    vkEnumerateInstanceVersion: ?PFN_vkEnumerateInstanceVersion = null,
    vkEnumerateInstanceExtensionProperties: ?PFN_vkEnumerateInstanceExtensionProperties = null,
    vkEnumerateInstanceLayerProperties: ?PFN_vkEnumerateInstanceLayerProperties = null,
    vkCreateInstance: ?PFN_vkCreateInstance = null,

    pub fn init() !Loader {
        const lib = try platform.loadVulkanLibrary();
        errdefer platform.unloadLibrary(lib);

        const get_instance_proc_addr = platform.getSymbol(lib, "vkGetInstanceProcAddr") orelse
            return platform.LoadError.SymbolNotFound;

        var loader = Loader{
            .library_handle = lib,
            .vkGetInstanceProcAddr = @ptrCast(@alignCast(get_instance_proc_addr)),
        };

        // Load global functions
        loader.vkEnumerateInstanceVersion = loader.loadGlobalFunction("vkEnumerateInstanceVersion", PFN_vkEnumerateInstanceVersion);
        loader.vkEnumerateInstanceExtensionProperties = loader.loadGlobalFunction("vkEnumerateInstanceExtensionProperties", PFN_vkEnumerateInstanceExtensionProperties) orelse
            return platform.LoadError.SymbolNotFound;
        loader.vkEnumerateInstanceLayerProperties = loader.loadGlobalFunction("vkEnumerateInstanceLayerProperties", PFN_vkEnumerateInstanceLayerProperties) orelse
            return platform.LoadError.SymbolNotFound;
        loader.vkCreateInstance = loader.loadGlobalFunction("vkCreateInstance", PFN_vkCreateInstance) orelse
            return platform.LoadError.SymbolNotFound;

        return loader;
    }

    pub fn deinit(self: *Loader) void {
        platform.unloadLibrary(self.library_handle);
    }

    /// Enumerates available instance extensions.
    ///
    /// If `p_layer_name` is null, returns all available instance extensions.
    /// If `p_layer_name` is provided, returns extensions for that specific layer.
    ///
    /// The caller is responsible for freeing the returned slice using the same allocator.
    ///
    /// Returns an error if:
    /// - `vkEnumerateInstanceExtensionProperties` is not available
    /// - The Vulkan call fails
    /// - Memory allocation fails
    pub fn getVulkanInstanceExtensions(
        self: *const Loader,
        allocator: std.mem.Allocator,
        p_layer_name: ?[:0]const u8,
    ) LoaderError![]ExtensionProperties {
        const enumerate_fn = self.vkEnumerateInstanceExtensionProperties orelse
            return LoaderError.FunctionNotAvailable;

        // First call: get the count
        var extension_count: u32 = 0;
        const layer_name_ptr: ?[*:0]const u8 = if (p_layer_name) |name| name.ptr else null;
        const result = enumerate_fn(layer_name_ptr, &extension_count, null);

        if (result != .success and result != .incomplete) {
            return LoaderError.EnumerationFailed;
        }

        if (extension_count == 0) {
            return try allocator.alloc(ExtensionProperties, 0);
        }

        // Second call: get the actual data
        const extension_list = try allocator.alloc(ExtensionProperties, extension_count);
        errdefer allocator.free(extension_list);

        const result2 = enumerate_fn(layer_name_ptr, &extension_count, extension_list.ptr);
        if (result2 != .success) {
            return LoaderError.EnumerationFailed;
        }

        return extension_list;
    }

    fn loadGlobalFunction(self: *Loader, comptime name: [:0]const u8, comptime FnType: type) ?FnType {
        const func = self.vkGetInstanceProcAddr(null, name);
        if (func) |f| {
            return @ptrCast(@alignCast(f));
        }
        return null;
    }

    pub fn createInstanceDispatch(self: *Loader, instance: Instance) !InstanceDispatch {
        return InstanceDispatch.init(self.vkGetInstanceProcAddr, instance);
    }

    pub fn createDeviceDispatch(_: *Loader, get_device_proc_addr: PFN_vkGetDeviceProcAddr, device: Device) !DeviceDispatch {
        return DeviceDispatch.init(get_device_proc_addr, device);
    }
};

// ============================================================================
// Instance Dispatch Table
// ============================================================================

pub const InstanceDispatch = struct {
    vkDestroyInstance: PFN_vkDestroyInstance,
    vkEnumeratePhysicalDevices: PFN_vkEnumeratePhysicalDevices,
    vkGetPhysicalDeviceProperties: PFN_vkGetPhysicalDeviceProperties,
    vkGetPhysicalDeviceFeatures: PFN_vkGetPhysicalDeviceFeatures,
    vkGetPhysicalDeviceMemoryProperties: PFN_vkGetPhysicalDeviceMemoryProperties,
    vkGetPhysicalDeviceQueueFamilyProperties: PFN_vkGetPhysicalDeviceQueueFamilyProperties,
    vkGetPhysicalDeviceFormatProperties: PFN_vkGetPhysicalDeviceFormatProperties,
    vkGetPhysicalDeviceImageFormatProperties: PFN_vkGetPhysicalDeviceImageFormatProperties,
    vkGetPhysicalDeviceSparseImageFormatProperties: PFN_vkGetPhysicalDeviceSparseImageFormatProperties,
    vkCreateDevice: PFN_vkCreateDevice,
    vkGetDeviceProcAddr: PFN_vkGetDeviceProcAddr,

    // Vulkan 1.1
    vkEnumeratePhysicalDeviceGroups: ?PFN_vkEnumeratePhysicalDeviceGroups = null,
    vkGetPhysicalDeviceFeatures2: ?PFN_vkGetPhysicalDeviceFeatures2 = null,
    vkGetPhysicalDeviceProperties2: ?PFN_vkGetPhysicalDeviceProperties2 = null,
    vkGetPhysicalDeviceFormatProperties2: ?PFN_vkGetPhysicalDeviceFormatProperties2 = null,
    vkGetPhysicalDeviceImageFormatProperties2: ?PFN_vkGetPhysicalDeviceImageFormatProperties2 = null,
    vkGetPhysicalDeviceQueueFamilyProperties2: ?PFN_vkGetPhysicalDeviceQueueFamilyProperties2 = null,
    vkGetPhysicalDeviceMemoryProperties2: ?PFN_vkGetPhysicalDeviceMemoryProperties2 = null,
    vkGetPhysicalDeviceSparseImageFormatProperties2: ?PFN_vkGetPhysicalDeviceSparseImageFormatProperties2 = null,
    vkGetPhysicalDeviceExternalBufferProperties: ?PFN_vkGetPhysicalDeviceExternalBufferProperties = null,
    vkGetPhysicalDeviceExternalFenceProperties: ?PFN_vkGetPhysicalDeviceExternalFenceProperties = null,
    vkGetPhysicalDeviceExternalSemaphoreProperties: ?PFN_vkGetPhysicalDeviceExternalSemaphoreProperties = null,

    // Vulkan 1.3
    vkGetPhysicalDeviceToolProperties: ?PFN_vkGetPhysicalDeviceToolProperties = null,

    // Extension functions
    vkDestroySurfaceKHR: ?PFN_vkDestroySurfaceKHR = null,
    vkGetPhysicalDeviceSurfaceSupportKHR: ?PFN_vkGetPhysicalDeviceSurfaceSupportKHR = null,
    vkGetPhysicalDeviceSurfaceCapabilitiesKHR: ?PFN_vkGetPhysicalDeviceSurfaceCapabilitiesKHR = null,
    vkGetPhysicalDeviceSurfaceFormatsKHR: ?PFN_vkGetPhysicalDeviceSurfaceFormatsKHR = null,
    vkGetPhysicalDeviceSurfacePresentModesKHR: ?PFN_vkGetPhysicalDeviceSurfacePresentModesKHR = null,

    vkCreateWaylandSurfaceKHR: ?PFN_vkCreateWaylandSurfaceKHR = null,
    vkGetPhysicalDeviceWaylandPresentationSupportKHR: ?PFN_vkGetPhysicalDeviceWaylandPresentationSupportKHR = null,

    vkCreateXcbSurfaceKHR: ?PFN_vkCreateXcbSurfaceKHR = null,
    vkGetPhysicalDeviceXcbPresentationSupportKHR: ?PFN_vkGetPhysicalDeviceXcbPresentationSupportKHR = null,

    vkCreateXlibSurfaceKHR: ?PFN_vkCreateXlibSurfaceKHR = null,
    vkGetPhysicalDeviceXlibPresentationSupportKHR: ?PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR = null,

    vkCreateWin32SurfaceKHR: ?PFN_vkCreateWin32SurfaceKHR = null,
    vkGetPhysicalDeviceWin32PresentationSupportKHR: ?PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR = null,

    // VK_KHR_fragment_shading_rate
    vkGetPhysicalDeviceFragmentShadingRatesKHR: ?PFN_vkGetPhysicalDeviceFragmentShadingRatesKHR = null,

    fn init(get_proc: PFN_vkGetInstanceProcAddr, instance: Instance) !InstanceDispatch {
        return InstanceDispatch{
            .vkDestroyInstance = try loadInstanceFunction(get_proc, instance, "vkDestroyInstance", PFN_vkDestroyInstance),
            .vkEnumeratePhysicalDevices = try loadInstanceFunction(get_proc, instance, "vkEnumeratePhysicalDevices", PFN_vkEnumeratePhysicalDevices),
            .vkGetPhysicalDeviceProperties = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceProperties", PFN_vkGetPhysicalDeviceProperties),
            .vkGetPhysicalDeviceFeatures = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceFeatures", PFN_vkGetPhysicalDeviceFeatures),
            .vkGetPhysicalDeviceMemoryProperties = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceMemoryProperties", PFN_vkGetPhysicalDeviceMemoryProperties),
            .vkGetPhysicalDeviceQueueFamilyProperties = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceQueueFamilyProperties", PFN_vkGetPhysicalDeviceQueueFamilyProperties),
            .vkGetPhysicalDeviceFormatProperties = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceFormatProperties", PFN_vkGetPhysicalDeviceFormatProperties),
            .vkGetPhysicalDeviceImageFormatProperties = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceImageFormatProperties", PFN_vkGetPhysicalDeviceImageFormatProperties),
            .vkGetPhysicalDeviceSparseImageFormatProperties = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceSparseImageFormatProperties", PFN_vkGetPhysicalDeviceSparseImageFormatProperties),
            .vkCreateDevice = try loadInstanceFunction(get_proc, instance, "vkCreateDevice", PFN_vkCreateDevice),
            .vkGetDeviceProcAddr = try loadInstanceFunction(get_proc, instance, "vkGetDeviceProcAddr", PFN_vkGetDeviceProcAddr),

            // Vulkan 1.1
            .vkEnumeratePhysicalDeviceGroups = loadOptionalInstanceFunction(get_proc, instance, "vkEnumeratePhysicalDeviceGroups", PFN_vkEnumeratePhysicalDeviceGroups),
            .vkGetPhysicalDeviceFeatures2 = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceFeatures2", PFN_vkGetPhysicalDeviceFeatures2),
            .vkGetPhysicalDeviceProperties2 = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceProperties2", PFN_vkGetPhysicalDeviceProperties2),
            .vkGetPhysicalDeviceFormatProperties2 = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceFormatProperties2", PFN_vkGetPhysicalDeviceFormatProperties2),
            .vkGetPhysicalDeviceImageFormatProperties2 = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceImageFormatProperties2", PFN_vkGetPhysicalDeviceImageFormatProperties2),
            .vkGetPhysicalDeviceQueueFamilyProperties2 = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceQueueFamilyProperties2", PFN_vkGetPhysicalDeviceQueueFamilyProperties2),
            .vkGetPhysicalDeviceMemoryProperties2 = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceMemoryProperties2", PFN_vkGetPhysicalDeviceMemoryProperties2),
            .vkGetPhysicalDeviceSparseImageFormatProperties2 = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceSparseImageFormatProperties2", PFN_vkGetPhysicalDeviceSparseImageFormatProperties2),
            .vkGetPhysicalDeviceExternalBufferProperties = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceExternalBufferProperties", PFN_vkGetPhysicalDeviceExternalBufferProperties),
            .vkGetPhysicalDeviceExternalFenceProperties = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceExternalFenceProperties", PFN_vkGetPhysicalDeviceExternalFenceProperties),
            .vkGetPhysicalDeviceExternalSemaphoreProperties = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceExternalSemaphoreProperties", PFN_vkGetPhysicalDeviceExternalSemaphoreProperties),

            // Vulkan 1.3
            .vkGetPhysicalDeviceToolProperties = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceToolProperties", PFN_vkGetPhysicalDeviceToolProperties),

            // Extension functions
            .vkDestroySurfaceKHR = loadOptionalInstanceFunction(get_proc, instance, "vkDestroySurfaceKHR", PFN_vkDestroySurfaceKHR),
            .vkGetPhysicalDeviceSurfaceSupportKHR = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceSurfaceSupportKHR", PFN_vkGetPhysicalDeviceSurfaceSupportKHR),
            .vkGetPhysicalDeviceSurfaceCapabilitiesKHR = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceSurfaceCapabilitiesKHR", PFN_vkGetPhysicalDeviceSurfaceCapabilitiesKHR),
            .vkGetPhysicalDeviceSurfaceFormatsKHR = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceSurfaceFormatsKHR", PFN_vkGetPhysicalDeviceSurfaceFormatsKHR),
            .vkGetPhysicalDeviceSurfacePresentModesKHR = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceSurfacePresentModesKHR", PFN_vkGetPhysicalDeviceSurfacePresentModesKHR),

            .vkCreateWaylandSurfaceKHR = loadOptionalInstanceFunction(get_proc, instance, "vkCreateWaylandSurfaceKHR", PFN_vkCreateWaylandSurfaceKHR),
            .vkGetPhysicalDeviceWaylandPresentationSupportKHR = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceWaylandPresentationSupportKHR", PFN_vkGetPhysicalDeviceWaylandPresentationSupportKHR),

            .vkCreateXcbSurfaceKHR = loadOptionalInstanceFunction(get_proc, instance, "vkCreateXcbSurfaceKHR", PFN_vkCreateXcbSurfaceKHR),
            .vkGetPhysicalDeviceXcbPresentationSupportKHR = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceXcbPresentationSupportKHR", PFN_vkGetPhysicalDeviceXcbPresentationSupportKHR),

            .vkCreateXlibSurfaceKHR = loadOptionalInstanceFunction(get_proc, instance, "vkCreateXlibSurfaceKHR", PFN_vkCreateXlibSurfaceKHR),
            .vkGetPhysicalDeviceXlibPresentationSupportKHR = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceXlibPresentationSupportKHR", PFN_vkGetPhysicalDeviceXlibPresentationSupportKHR),

            .vkCreateWin32SurfaceKHR = loadOptionalInstanceFunction(get_proc, instance, "vkCreateWin32SurfaceKHR", PFN_vkCreateWin32SurfaceKHR),
            .vkGetPhysicalDeviceWin32PresentationSupportKHR = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceWin32PresentationSupportKHR", PFN_vkGetPhysicalDeviceWin32PresentationSupportKHR),

            // VK_KHR_fragment_shading_rate
            .vkGetPhysicalDeviceFragmentShadingRatesKHR = loadOptionalInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceFragmentShadingRatesKHR", PFN_vkGetPhysicalDeviceFragmentShadingRatesKHR),
        };
    }

    pub fn createDeviceDispatch(self: *const InstanceDispatch, device: Device) !DeviceDispatch {
        return DeviceDispatch.init(self.vkGetDeviceProcAddr, device);
    }
};

fn loadOptionalInstanceFunction(
    get_proc: PFN_vkGetInstanceProcAddr,
    instance: Instance,
    comptime name: [:0]const u8,
    comptime FnType: type,
) ?FnType {
    const func = get_proc(instance, name);
    if (func) |f| {
        return @ptrCast(@alignCast(f));
    }
    return null;
}

fn loadOptionalDeviceFunction(
    get_proc: PFN_vkGetDeviceProcAddr,
    device: Device,
    comptime name: [:0]const u8,
    comptime FnType: type,
) ?FnType {
    const func = get_proc(device, name);
    if (func) |f| {
        return @ptrCast(@alignCast(f));
    }
    return null;
}

fn loadInstanceFunction(
    get_proc: PFN_vkGetInstanceProcAddr,
    instance: Instance,
    comptime name: [:0]const u8,
    comptime FnType: type,
) !FnType {
    const func = get_proc(instance, name) orelse return platform.LoadError.SymbolNotFound;
    return @ptrCast(@alignCast(func));
}

// ============================================================================
// Device Dispatch Table
// ============================================================================

pub const DeviceDispatch = struct {
    vkDestroyDevice: PFN_vkDestroyDevice,
    vkGetDeviceQueue: PFN_vkGetDeviceQueue,
    vkDeviceWaitIdle: PFN_vkDeviceWaitIdle,
    vkQueueWaitIdle: PFN_vkQueueWaitIdle,
    vkQueueSubmit: PFN_vkQueueSubmit,

    vkAllocateMemory: PFN_vkAllocateMemory,
    vkFreeMemory: PFN_vkFreeMemory,
    vkMapMemory: PFN_vkMapMemory,
    vkUnmapMemory: PFN_vkUnmapMemory,
    vkFlushMappedMemoryRanges: PFN_vkFlushMappedMemoryRanges,
    vkInvalidateMappedMemoryRanges: PFN_vkInvalidateMappedMemoryRanges,
    vkGetDeviceMemoryCommitment: PFN_vkGetDeviceMemoryCommitment,

    vkCreateBuffer: PFN_vkCreateBuffer,
    vkDestroyBuffer: PFN_vkDestroyBuffer,
    vkGetBufferMemoryRequirements: PFN_vkGetBufferMemoryRequirements,
    vkBindBufferMemory: PFN_vkBindBufferMemory,
    vkCreateBufferView: PFN_vkCreateBufferView,
    vkDestroyBufferView: PFN_vkDestroyBufferView,

    vkCreateImage: PFN_vkCreateImage,
    vkDestroyImage: PFN_vkDestroyImage,
    vkGetImageMemoryRequirements: PFN_vkGetImageMemoryRequirements,
    vkBindImageMemory: PFN_vkBindImageMemory,
    vkGetImageSubresourceLayout: PFN_vkGetImageSubresourceLayout,
    vkCreateImageView: PFN_vkCreateImageView,
    vkDestroyImageView: PFN_vkDestroyImageView,

    vkCreateCommandPool: PFN_vkCreateCommandPool,
    vkDestroyCommandPool: PFN_vkDestroyCommandPool,
    vkAllocateCommandBuffers: PFN_vkAllocateCommandBuffers,
    vkFreeCommandBuffers: PFN_vkFreeCommandBuffers,
    vkBeginCommandBuffer: PFN_vkBeginCommandBuffer,
    vkEndCommandBuffer: PFN_vkEndCommandBuffer,
    vkResetCommandBuffer: PFN_vkResetCommandBuffer,
    vkCmdExecuteCommands: PFN_vkCmdExecuteCommands,

    vkCreateFence: PFN_vkCreateFence,
    vkDestroyFence: PFN_vkDestroyFence,
    vkGetFenceStatus: PFN_vkGetFenceStatus,
    vkWaitForFences: PFN_vkWaitForFences,
    vkResetFences: PFN_vkResetFences,
    vkCreateSemaphore: PFN_vkCreateSemaphore,
    vkDestroySemaphore: PFN_vkDestroySemaphore,

    vkCreateShaderModule: PFN_vkCreateShaderModule,
    vkDestroyShaderModule: PFN_vkDestroyShaderModule,
    vkCreatePipelineLayout: PFN_vkCreatePipelineLayout,
    vkDestroyPipelineLayout: PFN_vkDestroyPipelineLayout,

    // Descriptor management functions
    vkCreateDescriptorSetLayout: PFN_vkCreateDescriptorSetLayout,
    vkDestroyDescriptorSetLayout: PFN_vkDestroyDescriptorSetLayout,
    vkCreateDescriptorPool: PFN_vkCreateDescriptorPool,
    vkDestroyDescriptorPool: PFN_vkDestroyDescriptorPool,
    vkResetDescriptorPool: PFN_vkResetDescriptorPool,
    vkAllocateDescriptorSets: PFN_vkAllocateDescriptorSets,
    vkFreeDescriptorSets: PFN_vkFreeDescriptorSets,
    vkUpdateDescriptorSets: PFN_vkUpdateDescriptorSets,
    vkCreateSampler: PFN_vkCreateSampler,
    vkDestroySampler: PFN_vkDestroySampler,
    vkCmdPushDescriptorSetKHR: ?PFN_vkCmdPushDescriptorSetKHR = null,

    vkCreateGraphicsPipelines: PFN_vkCreateGraphicsPipelines,
    vkCreateComputePipelines: PFN_vkCreateComputePipelines,
    vkDestroyPipeline: PFN_vkDestroyPipeline,

    // Pipeline cache management
    vkCreatePipelineCache: PFN_vkCreatePipelineCache,
    vkDestroyPipelineCache: PFN_vkDestroyPipelineCache,
    vkGetPipelineCacheData: PFN_vkGetPipelineCacheData,
    vkMergePipelineCaches: PFN_vkMergePipelineCaches,

    vkCreateRenderPass: PFN_vkCreateRenderPass,
    vkDestroyRenderPass: PFN_vkDestroyRenderPass,
    vkCreateFramebuffer: PFN_vkCreateFramebuffer,
    vkDestroyFramebuffer: PFN_vkDestroyFramebuffer,
    vkCmdBeginRenderPass: PFN_vkCmdBeginRenderPass,
    vkCmdNextSubpass: PFN_vkCmdNextSubpass,
    vkCmdEndRenderPass: PFN_vkCmdEndRenderPass,

    // Command buffer binding functions
    vkCmdBindPipeline: PFN_vkCmdBindPipeline,
    vkCmdBindDescriptorSets: PFN_vkCmdBindDescriptorSets,
    vkCmdBindIndexBuffer: PFN_vkCmdBindIndexBuffer,
    vkCmdBindVertexBuffers: PFN_vkCmdBindVertexBuffers,
    vkCmdBindVertexBuffers2EXT: ?PFN_vkCmdBindVertexBuffers2EXT = null,
    vkCmdBindShadingRateImageNV: ?PFN_vkCmdBindShadingRateImageNV = null,
    vkCmdBindTransformFeedbackBuffersEXT: ?PFN_vkCmdBindTransformFeedbackBuffersEXT = null,

    // Core drawing functions
    vkCmdDraw: PFN_vkCmdDraw,
    vkCmdDrawIndexed: PFN_vkCmdDrawIndexed,
    vkCmdDrawIndirect: PFN_vkCmdDrawIndirect,
    vkCmdDrawIndexedIndirect: PFN_vkCmdDrawIndexedIndirect,
    vkCmdPushConstants: PFN_vkCmdPushConstants,
    vkCmdDispatch: PFN_vkCmdDispatch,
    vkCmdDispatchIndirect: PFN_vkCmdDispatchIndirect,

    // Mesh shader functions (Phase 3)
    vkCmdDrawMeshTasksNV: ?PFN_vkCmdDrawMeshTasksNV = null,
    vkCmdDrawMeshTasksIndirectNV: ?PFN_vkCmdDrawMeshTasksIndirectNV = null,
    vkCmdDrawMeshTasksIndirectCountNV: ?PFN_vkCmdDrawMeshTasksIndirectCountNV = null,
    vkCmdDrawMeshTasksEXT: ?PFN_vkCmdDrawMeshTasksEXT = null,
    vkCmdDrawMeshTasksIndirectEXT: ?PFN_vkCmdDrawMeshTasksIndirectEXT = null,
    vkCmdDrawMeshTasksIndirectCountEXT: ?PFN_vkCmdDrawMeshTasksIndirectCountEXT = null,

    // State setting functions
    vkCmdSetViewport: PFN_vkCmdSetViewport,
    vkCmdSetScissor: PFN_vkCmdSetScissor,
    vkCmdSetLineWidth: PFN_vkCmdSetLineWidth,
    vkCmdSetDepthBias: PFN_vkCmdSetDepthBias,
    vkCmdSetBlendConstants: PFN_vkCmdSetBlendConstants,
    vkCmdSetDepthBounds: PFN_vkCmdSetDepthBounds,
    vkCmdSetStencilCompareMask: PFN_vkCmdSetStencilCompareMask,
    vkCmdSetStencilWriteMask: PFN_vkCmdSetStencilWriteMask,
    vkCmdSetStencilReference: PFN_vkCmdSetStencilReference,

    // Copy and transfer functions
    vkCmdCopyBuffer: PFN_vkCmdCopyBuffer,
    vkCmdCopyImage: PFN_vkCmdCopyImage,
    vkCmdCopyBufferToImage: PFN_vkCmdCopyBufferToImage,
    vkCmdCopyImageToBuffer: PFN_vkCmdCopyImageToBuffer,
    vkCmdBlitImage: PFN_vkCmdBlitImage,
    vkCmdFillBuffer: PFN_vkCmdFillBuffer,
    vkCmdUpdateBuffer: PFN_vkCmdUpdateBuffer,
    vkCmdResolveImage: PFN_vkCmdResolveImage,

    // Clear functions (missing ones only)
    vkCmdClearColorImage: PFN_vkCmdClearColorImage,
    vkCmdClearDepthStencilImage: PFN_vkCmdClearDepthStencilImage,

    // Query functions
    vkCmdBeginQuery: PFN_vkCmdBeginQuery,
    vkCmdEndQuery: PFN_vkCmdEndQuery,
    vkCmdResetQueryPool: PFN_vkCmdResetQueryPool,
    vkCmdCopyQueryPoolResults: PFN_vkCmdCopyQueryPoolResults,
    vkCmdWriteTimestamp: PFN_vkCmdWriteTimestamp,

    // Query management functions
    vkGetQueryPoolResults: PFN_vkGetQueryPoolResults,

    // Event synchronization functions
    vkCreateEvent: PFN_vkCreateEvent,
    vkDestroyEvent: PFN_vkDestroyEvent,
    vkGetEventStatus: PFN_vkGetEventStatus,
    vkSetEvent: PFN_vkSetEvent,
    vkResetEvent: PFN_vkResetEvent,
    vkCmdSetEvent: PFN_vkCmdSetEvent,
    vkCmdResetEvent: PFN_vkCmdResetEvent,
    vkCmdWaitEvents: PFN_vkCmdWaitEvents,

    // Advanced synchronization functions (Phase 3)
    vkCreateSemaphoreWithTypesKHR: ?PFN_vkCreateSemaphoreWithTypesKHR = null,

    // Vulkan 1.1
    vkBindBufferMemory2: ?PFN_vkBindBufferMemory2 = null,
    vkBindImageMemory2: ?PFN_vkBindImageMemory2 = null,
    vkGetDeviceGroupPeerMemoryFeatures: ?PFN_vkGetDeviceGroupPeerMemoryFeatures = null,
    vkCmdSetDeviceMask: ?PFN_vkCmdSetDeviceMask = null,
    vkCmdDispatchBase: ?PFN_vkCmdDispatchBase = null,
    vkGetImageMemoryRequirements2: ?PFN_vkGetImageMemoryRequirements2 = null,
    vkGetBufferMemoryRequirements2: ?PFN_vkGetBufferMemoryRequirements2 = null,
    vkGetDeviceQueue2: ?PFN_vkGetDeviceQueue2 = null,
    vkTrimCommandPool: ?PFN_vkTrimCommandPool = null,
    vkResetCommandPool: ?PFN_vkResetCommandPool = null,

    // Vulkan 1.2
    vkCmdDrawIndirectCount: ?PFN_vkCmdDrawIndirectCount = null,
    vkCmdDrawIndexedIndirectCount: ?PFN_vkCmdDrawIndexedIndirectCount = null,
    vkCreateRenderPass2: ?PFN_vkCreateRenderPass2 = null,
    vkCmdBeginRenderPass2: ?PFN_vkCmdBeginRenderPass2 = null,
    vkCmdNextSubpass2: ?PFN_vkCmdNextSubpass2 = null,
    vkCmdEndRenderPass2: ?PFN_vkCmdEndRenderPass2 = null,
    vkResetQueryPool: ?PFN_vkResetQueryPool = null,
    vkGetSemaphoreCounterValue: ?PFN_vkGetSemaphoreCounterValue = null,
    vkWaitSemaphores: ?PFN_vkWaitSemaphores = null,
    vkSignalSemaphore: ?PFN_vkSignalSemaphore = null,
    vkGetBufferDeviceAddress: ?PFN_vkGetBufferDeviceAddress = null,
    vkGetBufferOpaqueCaptureAddress: ?PFN_vkGetBufferOpaqueCaptureAddress = null,
    vkGetDeviceMemoryOpaqueCaptureAddress: ?PFN_vkGetDeviceMemoryOpaqueCaptureAddress = null,

    // Vulkan 1.3
    vkCreatePrivateDataSlot: ?PFN_vkCreatePrivateDataSlot = null,

    // Vulkan 1.4 / Maintenance5
    vkCmdBindIndexBuffer2KHR: ?PFN_vkCmdBindIndexBuffer2KHR = null,
    vkGetDeviceImageSubresourceLayoutKHR: ?PFN_vkGetDeviceImageSubresourceLayoutKHR = null,
    vkGetImageSubresourceLayout2KHR: ?PFN_vkGetImageSubresourceLayout2KHR = null,
    vkGetRenderingAreaGranularityKHR: ?PFN_vkGetRenderingAreaGranularityKHR = null,
    vkDestroyPrivateDataSlot: ?PFN_vkDestroyPrivateDataSlot = null,
    vkSetPrivateData: ?PFN_vkSetPrivateData = null,
    vkGetPrivateData: ?PFN_vkGetPrivateData = null,
    vkCmdSetEvent2: ?PFN_vkCmdSetEvent2 = null,
    vkCmdResetEvent2: ?PFN_vkCmdResetEvent2 = null,
    vkCmdWaitEvents2: ?PFN_vkCmdWaitEvents2 = null,
    vkCmdPipelineBarrier: ?PFN_vkCmdPipelineBarrier = null,
    vkCmdPipelineBarrier2: ?PFN_vkCmdPipelineBarrier2 = null,
    vkQueueSubmit2: ?PFN_vkQueueSubmit2 = null,
    vkCmdWriteTimestamp2: ?PFN_vkCmdWriteTimestamp2 = null,
    vkCmdCopyBuffer2: ?PFN_vkCmdCopyBuffer2 = null,
    vkCmdCopyImage2: ?PFN_vkCmdCopyImage2 = null,
    vkCmdCopyBufferToImage2: ?PFN_vkCmdCopyBufferToImage2 = null,
    vkCmdCopyImageToBuffer2: ?PFN_vkCmdCopyImageToBuffer2 = null,
    vkCmdBlitImage2: ?PFN_vkCmdBlitImage2 = null,
    vkCmdResolveImage2: ?PFN_vkCmdResolveImage2 = null,
    vkCmdBeginRendering: ?PFN_vkCmdBeginRendering = null,
    vkCmdEndRendering: ?PFN_vkCmdEndRendering = null,
    vkCmdSetCullMode: ?PFN_vkCmdSetCullMode = null,
    vkCmdSetFrontFace: ?PFN_vkCmdSetFrontFace = null,
    vkCmdSetPrimitiveTopology: ?PFN_vkCmdSetPrimitiveTopology = null,
    vkCmdSetViewportWithCount: ?PFN_vkCmdSetViewportWithCount = null,
    vkCmdSetScissorWithCount: ?PFN_vkCmdSetScissorWithCount = null,
    vkCmdBindVertexBuffers2: ?PFN_vkCmdBindVertexBuffers2 = null,
    vkCmdSetDepthTestEnable: ?PFN_vkCmdSetDepthTestEnable = null,
    vkCmdSetDepthWriteEnable: ?PFN_vkCmdSetDepthWriteEnable = null,
    vkCmdSetDepthCompareOp: ?PFN_vkCmdSetDepthCompareOp = null,
    vkCmdSetDepthBoundsTestEnable: ?PFN_vkCmdSetDepthBoundsTestEnable = null,
    vkCmdSetStencilTestEnable: ?PFN_vkCmdSetStencilTestEnable = null,
    vkCmdSetStencilOp: ?PFN_vkCmdSetStencilOp = null,
    vkCmdSetRasterizerDiscardEnable: ?PFN_vkCmdSetRasterizerDiscardEnable = null,
    vkCmdSetDepthBiasEnable: ?PFN_vkCmdSetDepthBiasEnable = null,
    vkCmdSetPrimitiveRestartEnable: ?PFN_vkCmdSetPrimitiveRestartEnable = null,

    // Extension functions
    vkCreateSwapchainKHR: ?PFN_vkCreateSwapchainKHR = null,
    vkDestroySwapchainKHR: ?PFN_vkDestroySwapchainKHR = null,
    vkGetSwapchainImagesKHR: ?PFN_vkGetSwapchainImagesKHR = null,
    vkAcquireNextImageKHR: ?PFN_vkAcquireNextImageKHR = null,
    vkQueuePresentKHR: ?PFN_vkQueuePresentKHR = null,

    fn init(get_proc: PFN_vkGetDeviceProcAddr, device: Device) !DeviceDispatch {
        return DeviceDispatch{
            .vkDestroyDevice = try loadDeviceFunction(get_proc, device, "vkDestroyDevice", PFN_vkDestroyDevice),
            .vkGetDeviceQueue = try loadDeviceFunction(get_proc, device, "vkGetDeviceQueue", PFN_vkGetDeviceQueue),
            .vkDeviceWaitIdle = try loadDeviceFunction(get_proc, device, "vkDeviceWaitIdle", PFN_vkDeviceWaitIdle),
            .vkQueueWaitIdle = try loadDeviceFunction(get_proc, device, "vkQueueWaitIdle", PFN_vkQueueWaitIdle),
            .vkQueueSubmit = try loadDeviceFunction(get_proc, device, "vkQueueSubmit", PFN_vkQueueSubmit),

            .vkAllocateMemory = try loadDeviceFunction(get_proc, device, "vkAllocateMemory", PFN_vkAllocateMemory),
            .vkFreeMemory = try loadDeviceFunction(get_proc, device, "vkFreeMemory", PFN_vkFreeMemory),
            .vkMapMemory = try loadDeviceFunction(get_proc, device, "vkMapMemory", PFN_vkMapMemory),
            .vkUnmapMemory = try loadDeviceFunction(get_proc, device, "vkUnmapMemory", PFN_vkUnmapMemory),
            .vkFlushMappedMemoryRanges = try loadDeviceFunction(get_proc, device, "vkFlushMappedMemoryRanges", PFN_vkFlushMappedMemoryRanges),
            .vkInvalidateMappedMemoryRanges = try loadDeviceFunction(get_proc, device, "vkInvalidateMappedMemoryRanges", PFN_vkInvalidateMappedMemoryRanges),
            .vkGetDeviceMemoryCommitment = try loadDeviceFunction(get_proc, device, "vkGetDeviceMemoryCommitment", PFN_vkGetDeviceMemoryCommitment),

            .vkCreateBuffer = try loadDeviceFunction(get_proc, device, "vkCreateBuffer", PFN_vkCreateBuffer),
            .vkDestroyBuffer = try loadDeviceFunction(get_proc, device, "vkDestroyBuffer", PFN_vkDestroyBuffer),
            .vkGetBufferMemoryRequirements = try loadDeviceFunction(get_proc, device, "vkGetBufferMemoryRequirements", PFN_vkGetBufferMemoryRequirements),
            .vkBindBufferMemory = try loadDeviceFunction(get_proc, device, "vkBindBufferMemory", PFN_vkBindBufferMemory),
            .vkCreateBufferView = try loadDeviceFunction(get_proc, device, "vkCreateBufferView", PFN_vkCreateBufferView),
            .vkDestroyBufferView = try loadDeviceFunction(get_proc, device, "vkDestroyBufferView", PFN_vkDestroyBufferView),

            .vkCreateImage = try loadDeviceFunction(get_proc, device, "vkCreateImage", PFN_vkCreateImage),
            .vkDestroyImage = try loadDeviceFunction(get_proc, device, "vkDestroyImage", PFN_vkDestroyImage),
            .vkGetImageMemoryRequirements = try loadDeviceFunction(get_proc, device, "vkGetImageMemoryRequirements", PFN_vkGetImageMemoryRequirements),
            .vkBindImageMemory = try loadDeviceFunction(get_proc, device, "vkBindImageMemory", PFN_vkBindImageMemory),
            .vkGetImageSubresourceLayout = try loadDeviceFunction(get_proc, device, "vkGetImageSubresourceLayout", PFN_vkGetImageSubresourceLayout),
            .vkCreateImageView = try loadDeviceFunction(get_proc, device, "vkCreateImageView", PFN_vkCreateImageView),
            .vkDestroyImageView = try loadDeviceFunction(get_proc, device, "vkDestroyImageView", PFN_vkDestroyImageView),

            .vkCreateCommandPool = try loadDeviceFunction(get_proc, device, "vkCreateCommandPool", PFN_vkCreateCommandPool),
            .vkDestroyCommandPool = try loadDeviceFunction(get_proc, device, "vkDestroyCommandPool", PFN_vkDestroyCommandPool),
            .vkAllocateCommandBuffers = try loadDeviceFunction(get_proc, device, "vkAllocateCommandBuffers", PFN_vkAllocateCommandBuffers),
            .vkFreeCommandBuffers = try loadDeviceFunction(get_proc, device, "vkFreeCommandBuffers", PFN_vkFreeCommandBuffers),
            .vkBeginCommandBuffer = try loadDeviceFunction(get_proc, device, "vkBeginCommandBuffer", PFN_vkBeginCommandBuffer),
            .vkEndCommandBuffer = try loadDeviceFunction(get_proc, device, "vkEndCommandBuffer", PFN_vkEndCommandBuffer),
            .vkResetCommandBuffer = try loadDeviceFunction(get_proc, device, "vkResetCommandBuffer", PFN_vkResetCommandBuffer),
            .vkCmdExecuteCommands = try loadDeviceFunction(get_proc, device, "vkCmdExecuteCommands", PFN_vkCmdExecuteCommands),

            .vkCreateFence = try loadDeviceFunction(get_proc, device, "vkCreateFence", PFN_vkCreateFence),
            .vkDestroyFence = try loadDeviceFunction(get_proc, device, "vkDestroyFence", PFN_vkDestroyFence),
            .vkGetFenceStatus = try loadDeviceFunction(get_proc, device, "vkGetFenceStatus", PFN_vkGetFenceStatus),
            .vkWaitForFences = try loadDeviceFunction(get_proc, device, "vkWaitForFences", PFN_vkWaitForFences),
            .vkResetFences = try loadDeviceFunction(get_proc, device, "vkResetFences", PFN_vkResetFences),
            .vkCreateSemaphore = try loadDeviceFunction(get_proc, device, "vkCreateSemaphore", PFN_vkCreateSemaphore),
            .vkDestroySemaphore = try loadDeviceFunction(get_proc, device, "vkDestroySemaphore", PFN_vkDestroySemaphore),

            .vkCreateShaderModule = try loadDeviceFunction(get_proc, device, "vkCreateShaderModule", PFN_vkCreateShaderModule),
            .vkDestroyShaderModule = try loadDeviceFunction(get_proc, device, "vkDestroyShaderModule", PFN_vkDestroyShaderModule),
            .vkCreatePipelineLayout = try loadDeviceFunction(get_proc, device, "vkCreatePipelineLayout", PFN_vkCreatePipelineLayout),
            .vkDestroyPipelineLayout = try loadDeviceFunction(get_proc, device, "vkDestroyPipelineLayout", PFN_vkDestroyPipelineLayout),

            .vkCreateGraphicsPipelines = try loadDeviceFunction(get_proc, device, "vkCreateGraphicsPipelines", PFN_vkCreateGraphicsPipelines),
            .vkCreateComputePipelines = try loadDeviceFunction(get_proc, device, "vkCreateComputePipelines", PFN_vkCreateComputePipelines),
            .vkDestroyPipeline = try loadDeviceFunction(get_proc, device, "vkDestroyPipeline", PFN_vkDestroyPipeline),

            // Pipeline cache management
            .vkCreatePipelineCache = try loadDeviceFunction(get_proc, device, "vkCreatePipelineCache", PFN_vkCreatePipelineCache),
            .vkDestroyPipelineCache = try loadDeviceFunction(get_proc, device, "vkDestroyPipelineCache", PFN_vkDestroyPipelineCache),
            .vkGetPipelineCacheData = try loadDeviceFunction(get_proc, device, "vkGetPipelineCacheData", PFN_vkGetPipelineCacheData),
            .vkMergePipelineCaches = try loadDeviceFunction(get_proc, device, "vkMergePipelineCaches", PFN_vkMergePipelineCaches),

            // Descriptor management functions
            .vkCreateDescriptorSetLayout = try loadDeviceFunction(get_proc, device, "vkCreateDescriptorSetLayout", PFN_vkCreateDescriptorSetLayout),
            .vkDestroyDescriptorSetLayout = try loadDeviceFunction(get_proc, device, "vkDestroyDescriptorSetLayout", PFN_vkDestroyDescriptorSetLayout),
            .vkCreateDescriptorPool = try loadDeviceFunction(get_proc, device, "vkCreateDescriptorPool", PFN_vkCreateDescriptorPool),
            .vkDestroyDescriptorPool = try loadDeviceFunction(get_proc, device, "vkDestroyDescriptorPool", PFN_vkDestroyDescriptorPool),
            .vkResetDescriptorPool = try loadDeviceFunction(get_proc, device, "vkResetDescriptorPool", PFN_vkResetDescriptorPool),
            .vkAllocateDescriptorSets = try loadDeviceFunction(get_proc, device, "vkAllocateDescriptorSets", PFN_vkAllocateDescriptorSets),
            .vkFreeDescriptorSets = try loadDeviceFunction(get_proc, device, "vkFreeDescriptorSets", PFN_vkFreeDescriptorSets),
            .vkUpdateDescriptorSets = try loadDeviceFunction(get_proc, device, "vkUpdateDescriptorSets", PFN_vkUpdateDescriptorSets),
            .vkCreateSampler = try loadDeviceFunction(get_proc, device, "vkCreateSampler", PFN_vkCreateSampler),
            .vkDestroySampler = try loadDeviceFunction(get_proc, device, "vkDestroySampler", PFN_vkDestroySampler),

            .vkCreateRenderPass = try loadDeviceFunction(get_proc, device, "vkCreateRenderPass", PFN_vkCreateRenderPass),
            .vkDestroyRenderPass = try loadDeviceFunction(get_proc, device, "vkDestroyRenderPass", PFN_vkDestroyRenderPass),
            .vkCreateFramebuffer = try loadDeviceFunction(get_proc, device, "vkCreateFramebuffer", PFN_vkCreateFramebuffer),
            .vkDestroyFramebuffer = try loadDeviceFunction(get_proc, device, "vkDestroyFramebuffer", PFN_vkDestroyFramebuffer),
            .vkCmdBeginRenderPass = try loadDeviceFunction(get_proc, device, "vkCmdBeginRenderPass", PFN_vkCmdBeginRenderPass),
            .vkCmdNextSubpass = try loadDeviceFunction(get_proc, device, "vkCmdNextSubpass", PFN_vkCmdNextSubpass),
            .vkCmdEndRenderPass = try loadDeviceFunction(get_proc, device, "vkCmdEndRenderPass", PFN_vkCmdEndRenderPass),

            // Command buffer binding functions
            .vkCmdBindPipeline = try loadDeviceFunction(get_proc, device, "vkCmdBindPipeline", PFN_vkCmdBindPipeline),
            .vkCmdBindDescriptorSets = try loadDeviceFunction(get_proc, device, "vkCmdBindDescriptorSets", PFN_vkCmdBindDescriptorSets),
            .vkCmdBindIndexBuffer = try loadDeviceFunction(get_proc, device, "vkCmdBindIndexBuffer", PFN_vkCmdBindIndexBuffer),
            .vkCmdBindVertexBuffers = try loadDeviceFunction(get_proc, device, "vkCmdBindVertexBuffers", PFN_vkCmdBindVertexBuffers),
            .vkCmdBindVertexBuffers2EXT = loadOptionalDeviceFunction(get_proc, device, "vkCmdBindVertexBuffers2EXT", PFN_vkCmdBindVertexBuffers2EXT),
            .vkCmdBindShadingRateImageNV = loadOptionalDeviceFunction(get_proc, device, "vkCmdBindShadingRateImageNV", PFN_vkCmdBindShadingRateImageNV),
            .vkCmdBindTransformFeedbackBuffersEXT = loadOptionalDeviceFunction(get_proc, device, "vkCmdBindTransformFeedbackBuffersEXT", PFN_vkCmdBindTransformFeedbackBuffersEXT),

            // Core drawing functions
            .vkCmdDraw = try loadDeviceFunction(get_proc, device, "vkCmdDraw", PFN_vkCmdDraw),
            .vkCmdDrawIndexed = try loadDeviceFunction(get_proc, device, "vkCmdDrawIndexed", PFN_vkCmdDrawIndexed),
            .vkCmdDrawIndirect = try loadDeviceFunction(get_proc, device, "vkCmdDrawIndirect", PFN_vkCmdDrawIndirect),
            .vkCmdDrawIndexedIndirect = try loadDeviceFunction(get_proc, device, "vkCmdDrawIndexedIndirect", PFN_vkCmdDrawIndexedIndirect),
            .vkCmdPushConstants = try loadDeviceFunction(get_proc, device, "vkCmdPushConstants", PFN_vkCmdPushConstants),
            .vkCmdDispatch = try loadDeviceFunction(get_proc, device, "vkCmdDispatch", PFN_vkCmdDispatch),
            .vkCmdDispatchIndirect = try loadDeviceFunction(get_proc, device, "vkCmdDispatchIndirect", PFN_vkCmdDispatchIndirect),

            // State setting functions
            .vkCmdSetViewport = try loadDeviceFunction(get_proc, device, "vkCmdSetViewport", PFN_vkCmdSetViewport),
            .vkCmdSetScissor = try loadDeviceFunction(get_proc, device, "vkCmdSetScissor", PFN_vkCmdSetScissor),
            .vkCmdSetLineWidth = try loadDeviceFunction(get_proc, device, "vkCmdSetLineWidth", PFN_vkCmdSetLineWidth),
            .vkCmdSetDepthBias = try loadDeviceFunction(get_proc, device, "vkCmdSetDepthBias", PFN_vkCmdSetDepthBias),
            .vkCmdSetBlendConstants = try loadDeviceFunction(get_proc, device, "vkCmdSetBlendConstants", PFN_vkCmdSetBlendConstants),
            .vkCmdSetDepthBounds = try loadDeviceFunction(get_proc, device, "vkCmdSetDepthBounds", PFN_vkCmdSetDepthBounds),
            .vkCmdSetStencilCompareMask = try loadDeviceFunction(get_proc, device, "vkCmdSetStencilCompareMask", PFN_vkCmdSetStencilCompareMask),
            .vkCmdSetStencilWriteMask = try loadDeviceFunction(get_proc, device, "vkCmdSetStencilWriteMask", PFN_vkCmdSetStencilWriteMask),
            .vkCmdSetStencilReference = try loadDeviceFunction(get_proc, device, "vkCmdSetStencilReference", PFN_vkCmdSetStencilReference),

            // Copy and transfer functions
            .vkCmdCopyBuffer = try loadDeviceFunction(get_proc, device, "vkCmdCopyBuffer", PFN_vkCmdCopyBuffer),
            .vkCmdCopyImage = try loadDeviceFunction(get_proc, device, "vkCmdCopyImage", PFN_vkCmdCopyImage),
            .vkCmdCopyBufferToImage = try loadDeviceFunction(get_proc, device, "vkCmdCopyBufferToImage", PFN_vkCmdCopyBufferToImage),
            .vkCmdCopyImageToBuffer = try loadDeviceFunction(get_proc, device, "vkCmdCopyImageToBuffer", PFN_vkCmdCopyImageToBuffer),
            .vkCmdBlitImage = try loadDeviceFunction(get_proc, device, "vkCmdBlitImage", PFN_vkCmdBlitImage),
            .vkCmdFillBuffer = try loadDeviceFunction(get_proc, device, "vkCmdFillBuffer", PFN_vkCmdFillBuffer),
            .vkCmdUpdateBuffer = try loadDeviceFunction(get_proc, device, "vkCmdUpdateBuffer", PFN_vkCmdUpdateBuffer),
            .vkCmdResolveImage = try loadDeviceFunction(get_proc, device, "vkCmdResolveImage", PFN_vkCmdResolveImage),

            // Clear functions
            .vkCmdClearColorImage = try loadDeviceFunction(get_proc, device, "vkCmdClearColorImage", PFN_vkCmdClearColorImage),
            .vkCmdClearDepthStencilImage = try loadDeviceFunction(get_proc, device, "vkCmdClearDepthStencilImage", PFN_vkCmdClearDepthStencilImage),

            // Query functions
            .vkCmdBeginQuery = try loadDeviceFunction(get_proc, device, "vkCmdBeginQuery", PFN_vkCmdBeginQuery),
            .vkCmdEndQuery = try loadDeviceFunction(get_proc, device, "vkCmdEndQuery", PFN_vkCmdEndQuery),
            .vkCmdResetQueryPool = try loadDeviceFunction(get_proc, device, "vkCmdResetQueryPool", PFN_vkCmdResetQueryPool),
            .vkCmdCopyQueryPoolResults = try loadDeviceFunction(get_proc, device, "vkCmdCopyQueryPoolResults", PFN_vkCmdCopyQueryPoolResults),
            .vkCmdWriteTimestamp = try loadDeviceFunction(get_proc, device, "vkCmdWriteTimestamp", PFN_vkCmdWriteTimestamp),

            // Query management functions
            .vkGetQueryPoolResults = try loadDeviceFunction(get_proc, device, "vkGetQueryPoolResults", PFN_vkGetQueryPoolResults),

            // Mesh shader functions
            .vkCmdDrawMeshTasksNV = loadOptionalDeviceFunction(get_proc, device, "vkCmdDrawMeshTasksNV", PFN_vkCmdDrawMeshTasksNV),
            .vkCmdDrawMeshTasksIndirectNV = loadOptionalDeviceFunction(get_proc, device, "vkCmdDrawMeshTasksIndirectNV", PFN_vkCmdDrawMeshTasksIndirectNV),
            .vkCmdDrawMeshTasksIndirectCountNV = loadOptionalDeviceFunction(get_proc, device, "vkCmdDrawMeshTasksIndirectCountNV", PFN_vkCmdDrawMeshTasksIndirectCountNV),
            .vkCmdDrawMeshTasksEXT = loadOptionalDeviceFunction(get_proc, device, "vkCmdDrawMeshTasksEXT", PFN_vkCmdDrawMeshTasksEXT),
            .vkCmdDrawMeshTasksIndirectEXT = loadOptionalDeviceFunction(get_proc, device, "vkCmdDrawMeshTasksIndirectEXT", PFN_vkCmdDrawMeshTasksIndirectEXT),
            .vkCmdDrawMeshTasksIndirectCountEXT = loadOptionalDeviceFunction(get_proc, device, "vkCmdDrawMeshTasksIndirectCountEXT", PFN_vkCmdDrawMeshTasksIndirectCountEXT),

            // Event synchronization functions
            .vkCreateEvent = try loadDeviceFunction(get_proc, device, "vkCreateEvent", PFN_vkCreateEvent),
            .vkDestroyEvent = try loadDeviceFunction(get_proc, device, "vkDestroyEvent", PFN_vkDestroyEvent),
            .vkGetEventStatus = try loadDeviceFunction(get_proc, device, "vkGetEventStatus", PFN_vkGetEventStatus),
            .vkSetEvent = try loadDeviceFunction(get_proc, device, "vkSetEvent", PFN_vkSetEvent),
            .vkResetEvent = try loadDeviceFunction(get_proc, device, "vkResetEvent", PFN_vkResetEvent),
            .vkCmdSetEvent = try loadDeviceFunction(get_proc, device, "vkCmdSetEvent", PFN_vkCmdSetEvent),
            .vkCmdResetEvent = try loadDeviceFunction(get_proc, device, "vkCmdResetEvent", PFN_vkCmdResetEvent),
            .vkCmdWaitEvents = try loadDeviceFunction(get_proc, device, "vkCmdWaitEvents", PFN_vkCmdWaitEvents),

            // Advanced synchronization functions
            .vkCreateSemaphoreWithTypesKHR = loadOptionalDeviceFunction(get_proc, device, "vkCreateSemaphoreWithTypesKHR", PFN_vkCreateSemaphoreWithTypesKHR),

            // Vulkan 1.1
            .vkBindBufferMemory2 = loadOptionalDeviceFunction(get_proc, device, "vkBindBufferMemory2", PFN_vkBindBufferMemory2),
            .vkBindImageMemory2 = loadOptionalDeviceFunction(get_proc, device, "vkBindImageMemory2", PFN_vkBindImageMemory2),
            .vkGetDeviceGroupPeerMemoryFeatures = loadOptionalDeviceFunction(get_proc, device, "vkGetDeviceGroupPeerMemoryFeatures", PFN_vkGetDeviceGroupPeerMemoryFeatures),
            .vkCmdSetDeviceMask = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetDeviceMask", PFN_vkCmdSetDeviceMask),
            .vkCmdDispatchBase = loadOptionalDeviceFunction(get_proc, device, "vkCmdDispatchBase", PFN_vkCmdDispatchBase),
            .vkGetImageMemoryRequirements2 = loadOptionalDeviceFunction(get_proc, device, "vkGetImageMemoryRequirements2", PFN_vkGetImageMemoryRequirements2),
            .vkGetBufferMemoryRequirements2 = loadOptionalDeviceFunction(get_proc, device, "vkGetBufferMemoryRequirements2", PFN_vkGetBufferMemoryRequirements2),
            .vkGetDeviceQueue2 = loadOptionalDeviceFunction(get_proc, device, "vkGetDeviceQueue2", PFN_vkGetDeviceQueue2),
            .vkTrimCommandPool = loadOptionalDeviceFunction(get_proc, device, "vkTrimCommandPool", PFN_vkTrimCommandPool),
            .vkResetCommandPool = loadOptionalDeviceFunction(get_proc, device, "vkResetCommandPool", PFN_vkResetCommandPool),

            // Vulkan 1.2
            .vkCmdDrawIndirectCount = loadOptionalDeviceFunction(get_proc, device, "vkCmdDrawIndirectCount", PFN_vkCmdDrawIndirectCount),
            .vkCmdDrawIndexedIndirectCount = loadOptionalDeviceFunction(get_proc, device, "vkCmdDrawIndexedIndirectCount", PFN_vkCmdDrawIndexedIndirectCount),
            .vkCreateRenderPass2 = loadOptionalDeviceFunction(get_proc, device, "vkCreateRenderPass2", PFN_vkCreateRenderPass2),
            .vkCmdBeginRenderPass2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdBeginRenderPass2", PFN_vkCmdBeginRenderPass2),
            .vkCmdNextSubpass2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdNextSubpass2", PFN_vkCmdNextSubpass2),
            .vkCmdEndRenderPass2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdEndRenderPass2", PFN_vkCmdEndRenderPass2),
            .vkResetQueryPool = loadOptionalDeviceFunction(get_proc, device, "vkResetQueryPool", PFN_vkResetQueryPool),
            .vkGetSemaphoreCounterValue = loadOptionalDeviceFunction(get_proc, device, "vkGetSemaphoreCounterValue", PFN_vkGetSemaphoreCounterValue),
            .vkWaitSemaphores = loadOptionalDeviceFunction(get_proc, device, "vkWaitSemaphores", PFN_vkWaitSemaphores),
            .vkSignalSemaphore = loadOptionalDeviceFunction(get_proc, device, "vkSignalSemaphore", PFN_vkSignalSemaphore),
            .vkGetBufferDeviceAddress = loadOptionalDeviceFunction(get_proc, device, "vkGetBufferDeviceAddress", PFN_vkGetBufferDeviceAddress),
            .vkGetBufferOpaqueCaptureAddress = loadOptionalDeviceFunction(get_proc, device, "vkGetBufferOpaqueCaptureAddress", PFN_vkGetBufferOpaqueCaptureAddress),
            .vkGetDeviceMemoryOpaqueCaptureAddress = loadOptionalDeviceFunction(get_proc, device, "vkGetDeviceMemoryOpaqueCaptureAddress", PFN_vkGetDeviceMemoryOpaqueCaptureAddress),

            // Vulkan 1.3
            .vkCreatePrivateDataSlot = loadOptionalDeviceFunction(get_proc, device, "vkCreatePrivateDataSlot", PFN_vkCreatePrivateDataSlot),
            .vkDestroyPrivateDataSlot = loadOptionalDeviceFunction(get_proc, device, "vkDestroyPrivateDataSlot", PFN_vkDestroyPrivateDataSlot),
            .vkSetPrivateData = loadOptionalDeviceFunction(get_proc, device, "vkSetPrivateData", PFN_vkSetPrivateData),
            .vkGetPrivateData = loadOptionalDeviceFunction(get_proc, device, "vkGetPrivateData", PFN_vkGetPrivateData),
            .vkCmdSetEvent2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetEvent2", PFN_vkCmdSetEvent2),
            .vkCmdResetEvent2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdResetEvent2", PFN_vkCmdResetEvent2),
            .vkCmdWaitEvents2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdWaitEvents2", PFN_vkCmdWaitEvents2),
            .vkCmdPipelineBarrier = loadOptionalDeviceFunction(get_proc, device, "vkCmdPipelineBarrier", PFN_vkCmdPipelineBarrier),
            .vkCmdPipelineBarrier2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdPipelineBarrier2", PFN_vkCmdPipelineBarrier2),
            .vkQueueSubmit2 = loadOptionalDeviceFunction(get_proc, device, "vkQueueSubmit2", PFN_vkQueueSubmit2),
            .vkCmdWriteTimestamp2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdWriteTimestamp2", PFN_vkCmdWriteTimestamp2),
            .vkCmdCopyBuffer2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdCopyBuffer2", PFN_vkCmdCopyBuffer2),
            .vkCmdCopyImage2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdCopyImage2", PFN_vkCmdCopyImage2),
            .vkCmdCopyBufferToImage2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdCopyBufferToImage2", PFN_vkCmdCopyBufferToImage2),
            .vkCmdCopyImageToBuffer2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdCopyImageToBuffer2", PFN_vkCmdCopyImageToBuffer2),
            .vkCmdBlitImage2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdBlitImage2", PFN_vkCmdBlitImage2),
            .vkCmdResolveImage2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdResolveImage2", PFN_vkCmdResolveImage2),
            .vkCmdBeginRendering = loadOptionalDeviceFunction(get_proc, device, "vkCmdBeginRendering", PFN_vkCmdBeginRendering),
            .vkCmdEndRendering = loadOptionalDeviceFunction(get_proc, device, "vkCmdEndRendering", PFN_vkCmdEndRendering),
            .vkCmdSetCullMode = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetCullMode", PFN_vkCmdSetCullMode),
            .vkCmdSetFrontFace = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetFrontFace", PFN_vkCmdSetFrontFace),
            .vkCmdSetPrimitiveTopology = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetPrimitiveTopology", PFN_vkCmdSetPrimitiveTopology),
            .vkCmdSetViewportWithCount = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetViewportWithCount", PFN_vkCmdSetViewportWithCount),
            .vkCmdSetScissorWithCount = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetScissorWithCount", PFN_vkCmdSetScissorWithCount),
            .vkCmdBindVertexBuffers2 = loadOptionalDeviceFunction(get_proc, device, "vkCmdBindVertexBuffers2", PFN_vkCmdBindVertexBuffers2),
            .vkCmdSetDepthTestEnable = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetDepthTestEnable", PFN_vkCmdSetDepthTestEnable),
            .vkCmdSetDepthWriteEnable = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetDepthWriteEnable", PFN_vkCmdSetDepthWriteEnable),
            .vkCmdSetDepthCompareOp = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetDepthCompareOp", PFN_vkCmdSetDepthCompareOp),
            .vkCmdSetDepthBoundsTestEnable = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetDepthBoundsTestEnable", PFN_vkCmdSetDepthBoundsTestEnable),
            .vkCmdSetStencilTestEnable = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetStencilTestEnable", PFN_vkCmdSetStencilTestEnable),
            .vkCmdSetStencilOp = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetStencilOp", PFN_vkCmdSetStencilOp),
            .vkCmdSetRasterizerDiscardEnable = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetRasterizerDiscardEnable", PFN_vkCmdSetRasterizerDiscardEnable),
            .vkCmdSetDepthBiasEnable = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetDepthBiasEnable", PFN_vkCmdSetDepthBiasEnable),
            .vkCmdSetPrimitiveRestartEnable = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetPrimitiveRestartEnable", PFN_vkCmdSetPrimitiveRestartEnable),

            // Vulkan 1.4 / Maintenance5
            .vkCmdBindIndexBuffer2KHR = loadOptionalDeviceFunction(get_proc, device, "vkCmdBindIndexBuffer2KHR", PFN_vkCmdBindIndexBuffer2KHR),
            .vkGetDeviceImageSubresourceLayoutKHR = loadOptionalDeviceFunction(get_proc, device, "vkGetDeviceImageSubresourceLayoutKHR", PFN_vkGetDeviceImageSubresourceLayoutKHR),
            .vkGetImageSubresourceLayout2KHR = loadOptionalDeviceFunction(get_proc, device, "vkGetImageSubresourceLayout2KHR", PFN_vkGetImageSubresourceLayout2KHR),
            .vkGetRenderingAreaGranularityKHR = loadOptionalDeviceFunction(get_proc, device, "vkGetRenderingAreaGranularityKHR", PFN_vkGetRenderingAreaGranularityKHR),

            // Extension functions
            .vkCreateSwapchainKHR = loadOptionalDeviceFunction(get_proc, device, "vkCreateSwapchainKHR", PFN_vkCreateSwapchainKHR),
            .vkDestroySwapchainKHR = loadOptionalDeviceFunction(get_proc, device, "vkDestroySwapchainKHR", PFN_vkDestroySwapchainKHR),
            .vkGetSwapchainImagesKHR = loadOptionalDeviceFunction(get_proc, device, "vkGetSwapchainImagesKHR", PFN_vkGetSwapchainImagesKHR),
            .vkAcquireNextImageKHR = loadOptionalDeviceFunction(get_proc, device, "vkAcquireNextImageKHR", PFN_vkAcquireNextImageKHR),
            .vkQueuePresentKHR = loadOptionalDeviceFunction(get_proc, device, "vkQueuePresentKHR", PFN_vkQueuePresentKHR),

            // VK_KHR_push_descriptor
            .vkCmdPushDescriptorSetKHR = loadOptionalDeviceFunction(get_proc, device, "vkCmdPushDescriptorSetKHR", PFN_vkCmdPushDescriptorSetKHR),

            // VK_KHR_descriptor_update_template
            .vkCreateDescriptorUpdateTemplateKHR = loadOptionalDeviceFunction(get_proc, device, "vkCreateDescriptorUpdateTemplateKHR", PFN_vkCreateDescriptorUpdateTemplateKHR),
            .vkDestroyDescriptorUpdateTemplateKHR = loadOptionalDeviceFunction(get_proc, device, "vkDestroyDescriptorUpdateTemplateKHR", PFN_vkDestroyDescriptorUpdateTemplateKHR),
            .vkUpdateDescriptorSetWithTemplateKHR = loadOptionalDeviceFunction(get_proc, device, "vkUpdateDescriptorSetWithTemplateKHR", PFN_vkUpdateDescriptorSetWithTemplateKHR),

            // VK_KHR_fragment_shading_rate
            .vkCmdSetFragmentShadingRateKHR = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetFragmentShadingRateKHR", PFN_vkCmdSetFragmentShadingRateKHR),

            // VK_INTEL_performance_query
            .vkInitializePerformanceApiINTEL = loadOptionalDeviceFunction(get_proc, device, "vkInitializePerformanceApiINTEL", PFN_vkInitializePerformanceApiINTEL),
            .vkUninitializePerformanceApiINTEL = loadOptionalDeviceFunction(get_proc, device, "vkUninitializePerformanceApiINTEL", PFN_vkUninitializePerformanceApiINTEL),
            .vkCmdSetPerformanceMarkerINTEL = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetPerformanceMarkerINTEL", PFN_vkCmdSetPerformanceMarkerINTEL),
            .vkCmdSetPerformanceStreamMarkerINTEL = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetPerformanceStreamMarkerINTEL", PFN_vkCmdSetPerformanceStreamMarkerINTEL),
            .vkCmdSetPerformanceOverrideINTEL = loadOptionalDeviceFunction(get_proc, device, "vkCmdSetPerformanceOverrideINTEL", PFN_vkCmdSetPerformanceOverrideINTEL),
            .vkAcquirePerformanceConfigurationINTEL = loadOptionalDeviceFunction(get_proc, device, "vkAcquirePerformanceConfigurationINTEL", PFN_vkAcquirePerformanceConfigurationINTEL),
            .vkReleasePerformanceConfigurationINTEL = loadOptionalDeviceFunction(get_proc, device, "vkReleasePerformanceConfigurationINTEL", PFN_vkReleasePerformanceConfigurationINTEL),
            .vkQueueSetPerformanceConfigurationINTEL = loadOptionalDeviceFunction(get_proc, device, "vkQueueSetPerformanceConfigurationINTEL", PFN_vkQueueSetPerformanceConfigurationINTEL),
            .vkGetPerformanceParameterINTEL = loadOptionalDeviceFunction(get_proc, device, "vkGetPerformanceParameterINTEL", PFN_vkGetPerformanceParameterINTEL),
        };
    }
};

fn loadDeviceFunction(
    get_proc: PFN_vkGetDeviceProcAddr,
    device: Device,
    comptime name: [:0]const u8,
    comptime FnType: type,
) !FnType {
    const func = get_proc(device, name) orelse return platform.LoadError.SymbolNotFound;
    return @ptrCast(@alignCast(func));
}
