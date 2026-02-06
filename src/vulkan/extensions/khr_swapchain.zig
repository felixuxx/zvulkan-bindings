//! VK_KHR_swapchain extension
//! Presentation engine support

const types = @import("../types.zig");
const constants = @import("../constants.zig");
const khr_surface = @import("khr_surface.zig");

pub const KHR_SWAPCHAIN_EXTENSION_NAME = "VK_KHR_swapchain";

pub const SwapchainCreateFlagsKHR = packed struct(u32) {
    split_instance_bind_regions_khr: bool = false,
    protected_khr: bool = false,
    mutable_format_khr: bool = false,
    _padding: u29 = 0,
};

pub const SwapchainCreateInfoKHR = extern struct {
    s_type: types.StructureType = .swapchain_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: SwapchainCreateFlagsKHR = .{},
    surface: types.SurfaceKHR,
    min_image_count: u32,
    image_format: types.Format,
    image_color_space: khr_surface.ColorSpaceKHR,
    image_extent: types.Extent2D,
    image_array_layers: u32,
    image_usage: types.ImageUsageFlags,
    image_sharing_mode: types.SharingMode,
    queue_family_index_count: u32,
    p_queue_family_indices: ?[*]const u32,
    pre_transform: khr_surface.SurfaceTransformFlagBitsKHR,
    composite_alpha: khr_surface.CompositeAlphaFlagBitsKHR,
    present_mode: khr_surface.PresentModeKHR,
    clipped: types.Bool32,
    old_swapchain: types.SwapchainKHR = .null_handle,
};

pub const PresentInfoKHR = extern struct {
    s_type: types.StructureType = .present_info_khr,
    p_next: ?*const anyopaque = null,
    wait_semaphore_count: u32 = 0,
    p_wait_semaphores: ?[*]const types.Semaphore = null,
    swapchain_count: u32,
    p_swapchains: [*]const types.SwapchainKHR,
    p_image_indices: [*]const u32,
    p_results: ?[*]types.Result = null,
};
