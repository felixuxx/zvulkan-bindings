//! Main Vulkan bindings entry point
//! Provides dynamic loading and function pointer dispatch for Vulkan API

const std = @import("std");
const platform = @import("platform.zig");

pub const types = @import("types.zig");
pub const constants = @import("constants.zig");
pub const core_1_0 = @import("core_1_0.zig");
pub const khr_surface = @import("extensions/khr_surface.zig");
pub const khr_swapchain = @import("extensions/khr_swapchain.zig");
pub const khr_wayland_surface = @import("extensions/khr_wayland_surface.zig");
pub const khr_xcb_surface = @import("extensions/khr_xcb_surface.zig");
pub const khr_xlib_surface = @import("extensions/khr_xlib_surface.zig");
pub const khr_win32_surface = @import("extensions/khr_win32_surface.zig");

// Re-export commonly used types
pub const Instance = types.Instance;
pub const PhysicalDevice = types.PhysicalDevice;
pub const Device = types.Device;
pub const Queue = types.Queue;
pub const CommandBuffer = types.CommandBuffer;
pub const Result = types.Result;

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

// Instance functions
pub const PFN_vkDestroyInstance = *const fn (Instance, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkEnumeratePhysicalDevices = *const fn (Instance, *u32, ?[*]PhysicalDevice) callconv(.c) Result;
pub const PFN_vkGetPhysicalDeviceProperties = *const fn (PhysicalDevice, *core_1_0.PhysicalDeviceProperties) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceFeatures = *const fn (PhysicalDevice, *core_1_0.PhysicalDeviceFeatures) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceMemoryProperties = *const fn (PhysicalDevice, *core_1_0.PhysicalDeviceMemoryProperties) callconv(.c) void;
pub const PFN_vkGetPhysicalDeviceQueueFamilyProperties = *const fn (PhysicalDevice, *u32, ?[*]core_1_0.QueueFamilyProperties) callconv(.c) void;
pub const PFN_vkCreateDevice = *const fn (PhysicalDevice, *const core_1_0.DeviceCreateInfo, ?*const types.AllocationCallbacks, *Device) callconv(.c) Result;

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

// Buffer functions
pub const PFN_vkCreateBuffer = *const fn (Device, *const core_1_0.BufferCreateInfo, ?*const types.AllocationCallbacks, *types.Buffer) callconv(.c) Result;
pub const PFN_vkDestroyBuffer = *const fn (Device, types.Buffer, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkGetBufferMemoryRequirements = *const fn (Device, types.Buffer, *types.MemoryRequirements) callconv(.c) void;
pub const PFN_vkBindBufferMemory = *const fn (Device, types.Buffer, types.DeviceMemory, types.DeviceSize) callconv(.c) Result;

// Image functions
pub const PFN_vkCreateImage = *const fn (Device, *const core_1_0.ImageCreateInfo, ?*const types.AllocationCallbacks, *types.Image) callconv(.c) Result;
pub const PFN_vkDestroyImage = *const fn (Device, types.Image, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkGetImageMemoryRequirements = *const fn (Device, types.Image, *types.MemoryRequirements) callconv(.c) void;
pub const PFN_vkBindImageMemory = *const fn (Device, types.Image, types.DeviceMemory, types.DeviceSize) callconv(.c) Result;
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

// Synchronization functions
pub const PFN_vkCreateFence = *const fn (Device, *const core_1_0.FenceCreateInfo, ?*const types.AllocationCallbacks, *types.Fence) callconv(.c) Result;
pub const PFN_vkDestroyFence = *const fn (Device, types.Fence, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkWaitForFences = *const fn (Device, u32, [*]const types.Fence, types.Bool32, u64) callconv(.c) Result;
pub const PFN_vkResetFences = *const fn (Device, u32, [*]const types.Fence) callconv(.c) Result;
pub const PFN_vkCreateSemaphore = *const fn (Device, *const core_1_0.SemaphoreCreateInfo, ?*const types.AllocationCallbacks, *types.Semaphore) callconv(.c) Result;
pub const PFN_vkDestroySemaphore = *const fn (Device, types.Semaphore, ?*const types.AllocationCallbacks) callconv(.c) void;

// Shader and pipeline functions
pub const PFN_vkCreateShaderModule = *const fn (Device, *const core_1_0.ShaderModuleCreateInfo, ?*const types.AllocationCallbacks, *types.ShaderModule) callconv(.c) Result;
pub const PFN_vkDestroyShaderModule = *const fn (Device, types.ShaderModule, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkCreatePipelineLayout = *const fn (Device, *const core_1_0.PipelineLayoutCreateInfo, ?*const types.AllocationCallbacks, *types.PipelineLayout) callconv(.c) Result;
pub const PFN_vkDestroyPipelineLayout = *const fn (Device, types.PipelineLayout, ?*const types.AllocationCallbacks) callconv(.c) void;

// Render pass functions
pub const PFN_vkCreateRenderPass = *const fn (Device, *const core_1_0.RenderPassCreateInfo, ?*const types.AllocationCallbacks, *types.RenderPass) callconv(.c) Result;
pub const PFN_vkDestroyRenderPass = *const fn (Device, types.RenderPass, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkCreateFramebuffer = *const fn (Device, *const core_1_0.FramebufferCreateInfo, ?*const types.AllocationCallbacks, *types.Framebuffer) callconv(.c) Result;
pub const PFN_vkDestroyFramebuffer = *const fn (Device, types.Framebuffer, ?*const types.AllocationCallbacks) callconv(.c) void;
pub const PFN_vkCmdBeginRenderPass = *const fn (CommandBuffer, *const core_1_0.RenderPassBeginInfo, types.SubpassContents) callconv(.c) void;
pub const PFN_vkCmdEndRenderPass = *const fn (CommandBuffer) callconv(.c) void;

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
    vkCreateDevice: PFN_vkCreateDevice,
    vkGetDeviceProcAddr: PFN_vkGetDeviceProcAddr,

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

    fn init(get_proc: PFN_vkGetInstanceProcAddr, instance: Instance) !InstanceDispatch {
        return InstanceDispatch{
            .vkDestroyInstance = try loadInstanceFunction(get_proc, instance, "vkDestroyInstance", PFN_vkDestroyInstance),
            .vkEnumeratePhysicalDevices = try loadInstanceFunction(get_proc, instance, "vkEnumeratePhysicalDevices", PFN_vkEnumeratePhysicalDevices),
            .vkGetPhysicalDeviceProperties = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceProperties", PFN_vkGetPhysicalDeviceProperties),
            .vkGetPhysicalDeviceFeatures = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceFeatures", PFN_vkGetPhysicalDeviceFeatures),
            .vkGetPhysicalDeviceMemoryProperties = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceMemoryProperties", PFN_vkGetPhysicalDeviceMemoryProperties),
            .vkGetPhysicalDeviceQueueFamilyProperties = try loadInstanceFunction(get_proc, instance, "vkGetPhysicalDeviceQueueFamilyProperties", PFN_vkGetPhysicalDeviceQueueFamilyProperties),
            .vkCreateDevice = try loadInstanceFunction(get_proc, instance, "vkCreateDevice", PFN_vkCreateDevice),
            .vkGetDeviceProcAddr = try loadInstanceFunction(get_proc, instance, "vkGetDeviceProcAddr", PFN_vkGetDeviceProcAddr),

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

    vkCreateBuffer: PFN_vkCreateBuffer,
    vkDestroyBuffer: PFN_vkDestroyBuffer,
    vkGetBufferMemoryRequirements: PFN_vkGetBufferMemoryRequirements,
    vkBindBufferMemory: PFN_vkBindBufferMemory,

    vkCreateImage: PFN_vkCreateImage,
    vkDestroyImage: PFN_vkDestroyImage,
    vkGetImageMemoryRequirements: PFN_vkGetImageMemoryRequirements,
    vkBindImageMemory: PFN_vkBindImageMemory,
    vkCreateImageView: PFN_vkCreateImageView,
    vkDestroyImageView: PFN_vkDestroyImageView,

    vkCreateCommandPool: PFN_vkCreateCommandPool,
    vkDestroyCommandPool: PFN_vkDestroyCommandPool,
    vkAllocateCommandBuffers: PFN_vkAllocateCommandBuffers,
    vkFreeCommandBuffers: PFN_vkFreeCommandBuffers,
    vkBeginCommandBuffer: PFN_vkBeginCommandBuffer,
    vkEndCommandBuffer: PFN_vkEndCommandBuffer,
    vkResetCommandBuffer: PFN_vkResetCommandBuffer,

    vkCreateFence: PFN_vkCreateFence,
    vkDestroyFence: PFN_vkDestroyFence,
    vkWaitForFences: PFN_vkWaitForFences,
    vkResetFences: PFN_vkResetFences,
    vkCreateSemaphore: PFN_vkCreateSemaphore,
    vkDestroySemaphore: PFN_vkDestroySemaphore,

    vkCreateShaderModule: PFN_vkCreateShaderModule,
    vkDestroyShaderModule: PFN_vkDestroyShaderModule,
    vkCreatePipelineLayout: PFN_vkCreatePipelineLayout,
    vkDestroyPipelineLayout: PFN_vkDestroyPipelineLayout,

    vkCreateRenderPass: PFN_vkCreateRenderPass,
    vkDestroyRenderPass: PFN_vkDestroyRenderPass,
    vkCreateFramebuffer: PFN_vkCreateFramebuffer,
    vkDestroyFramebuffer: PFN_vkDestroyFramebuffer,
    vkCmdBeginRenderPass: PFN_vkCmdBeginRenderPass,
    vkCmdEndRenderPass: PFN_vkCmdEndRenderPass,

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

            .vkCreateBuffer = try loadDeviceFunction(get_proc, device, "vkCreateBuffer", PFN_vkCreateBuffer),
            .vkDestroyBuffer = try loadDeviceFunction(get_proc, device, "vkDestroyBuffer", PFN_vkDestroyBuffer),
            .vkGetBufferMemoryRequirements = try loadDeviceFunction(get_proc, device, "vkGetBufferMemoryRequirements", PFN_vkGetBufferMemoryRequirements),
            .vkBindBufferMemory = try loadDeviceFunction(get_proc, device, "vkBindBufferMemory", PFN_vkBindBufferMemory),

            .vkCreateImage = try loadDeviceFunction(get_proc, device, "vkCreateImage"),
            .vkDestroyImage = try loadDeviceFunction(get_proc, device, "vkDestroyImage"),
            .vkGetImageMemoryRequirements = try loadDeviceFunction(get_proc, device, "vkGetImageMemoryRequirements"),
            .vkBindImageMemory = try loadDeviceFunction(get_proc, device, "vkBindImageMemory"),
            .vkCreateImageView = try loadDeviceFunction(get_proc, device, "vkCreateImageView"),
            .vkDestroyImageView = try loadDeviceFunction(get_proc, device, "vkDestroyImageView"),

            .vkCreateCommandPool = try loadDeviceFunction(get_proc, device, "vkCreateCommandPool"),
            .vkDestroyCommandPool = try loadDeviceFunction(get_proc, device, "vkDestroyCommandPool"),
            .vkAllocateCommandBuffers = try loadDeviceFunction(get_proc, device, "vkAllocateCommandBuffers"),
            .vkFreeCommandBuffers = try loadDeviceFunction(get_proc, device, "vkFreeCommandBuffers"),
            .vkBeginCommandBuffer = try loadDeviceFunction(get_proc, device, "vkBeginCommandBuffer"),
            .vkEndCommandBuffer = try loadDeviceFunction(get_proc, device, "vkEndCommandBuffer"),
            .vkResetCommandBuffer = try loadDeviceFunction(get_proc, device, "vkResetCommandBuffer"),

            .vkCreateFence = try loadDeviceFunction(get_proc, device, "vkCreateFence"),
            .vkDestroyFence = try loadDeviceFunction(get_proc, device, "vkDestroyFence"),
            .vkWaitForFences = try loadDeviceFunction(get_proc, device, "vkWaitForFences"),
            .vkResetFences = try loadDeviceFunction(get_proc, device, "vkResetFences"),
            .vkCreateSemaphore = try loadDeviceFunction(get_proc, device, "vkCreateSemaphore"),
            .vkDestroySemaphore = try loadDeviceFunction(get_proc, device, "vkDestroySemaphore"),

            .vkCreateShaderModule = try loadDeviceFunction(get_proc, device, "vkCreateShaderModule"),
            .vkDestroyShaderModule = try loadDeviceFunction(get_proc, device, "vkDestroyShaderModule"),
            .vkCreatePipelineLayout = try loadDeviceFunction(get_proc, device, "vkCreatePipelineLayout"),
            .vkDestroyPipelineLayout = try loadDeviceFunction(get_proc, device, "vkDestroyPipelineLayout"),

            .vkCreateRenderPass = try loadDeviceFunction(get_proc, device, "vkCreateRenderPass"),
            .vkDestroyRenderPass = try loadDeviceFunction(get_proc, device, "vkDestroyRenderPass"),
            .vkCreateFramebuffer = try loadDeviceFunction(get_proc, device, "vkCreateFramebuffer"),
            .vkDestroyFramebuffer = try loadDeviceFunction(get_proc, device, "vkDestroyFramebuffer"),
            .vkCmdBeginRenderPass = try loadDeviceFunction(get_proc, device, "vkCmdBeginRenderPass", PFN_vkCmdBeginRenderPass),
            .vkCmdEndRenderPass = try loadDeviceFunction(get_proc, device, "vkCmdEndRenderPass", PFN_vkCmdEndRenderPass),

            // Extension functions
            .vkCreateSwapchainKHR = loadOptionalDeviceFunction(get_proc, device, "vkCreateSwapchainKHR", PFN_vkCreateSwapchainKHR),
            .vkDestroySwapchainKHR = loadOptionalDeviceFunction(get_proc, device, "vkDestroySwapchainKHR", PFN_vkDestroySwapchainKHR),
            .vkGetSwapchainImagesKHR = loadOptionalDeviceFunction(get_proc, device, "vkGetSwapchainImagesKHR", PFN_vkGetSwapchainImagesKHR),
            .vkAcquireNextImageKHR = loadOptionalDeviceFunction(get_proc, device, "vkAcquireNextImageKHR", PFN_vkAcquireNextImageKHR),
            .vkQueuePresentKHR = loadOptionalDeviceFunction(get_proc, device, "vkQueuePresentKHR", PFN_vkQueuePresentKHR),
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
