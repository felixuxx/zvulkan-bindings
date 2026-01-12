const std = @import("std");
const testing = std.testing;
const c = @cImport(@cInclude("stddef.h"));

// Import all Vulkan modules to test
const vk = @import("src/vulkan/vk.zig");
const types = @import("src/vulkan/types.zig");
const core_1_0 = @import("src/vulkan/core_1_0.zig");
const core_1_1 = @import("src/vulkan/core_1_1.zig");
const core_1_2 = @import("src/vulkan/core_1_2.zig");
const core_1_3 = @import("src/vulkan/core_1_3.zig");

// Helper functions for verification
fn documentStructSize(comptime T: type) void {
    const actual_size = @sizeOf(T);
    const actual_alignment = @alignOf(T);
    std.log.info("{s}: {} bytes, alignment: {}", .{ @typeName(T), actual_size, actual_alignment });
}

fn verifyCABI(comptime T: type) bool {
    // Check if struct uses C ABI (extern)
    const type_info = @typeInfo(T);
    if (type_info == .Struct) {
        return type_info.Struct.layout == .Extern;
    } else if (type_info == .Union) {
        return type_info.Union.layout == .Extern;
    }
    return false;
}

// ============ DOCUMENT ACTUAL STRUCT LAYOUTS ============

test "document actual struct sizes and properties" {
    std.log.info("=== STRUCT SIZE DOCUMENTATION ===", .{});

    // Basic types
    documentStructSize(types.Bool32);
    documentStructSize(types.DeviceSize);
    documentStructSize(types.DeviceAddress);
    documentStructSize(types.Flags);
    documentStructSize(types.SampleMask);
    documentStructSize(types.Result);
    documentStructSize(types.StructureType);

    // Handle types (platform dependent)
    documentStructSize(types.Instance);
    documentStructSize(types.PhysicalDevice);
    documentStructSize(types.Device);
    documentStructSize(types.Queue);
    documentStructSize(types.CommandBuffer);
    documentStructSize(types.Semaphore);
    documentStructSize(types.Fence);
    documentStructSize(types.DeviceMemory);
    documentStructSize(types.Buffer);
    documentStructSize(types.Image);
    documentStructSize(types.ImageView);
    documentStructSize(types.Sampler);
    documentStructSize(types.DescriptorSet);
    documentStructSize(types.DescriptorSetLayout);
    documentStructSize(types.Pipeline);
    documentStructSize(types.PipelineLayout);
    documentStructSize(types.ShaderModule);
    documentStructSize(types.RenderPass);
    documentStructSize(types.Framebuffer);
    documentStructSize(types.QueryPool);
    documentStructSize(types.Event);
    documentStructSize(types.SurfaceKHR);
    documentStructSize(types.SwapchainKHR);
    documentStructSize(types.DebugUtilsMessengerEXT);

    // Geometric types
    documentStructSize(types.Offset2D);
    documentStructSize(types.Offset3D);
    documentStructSize(types.Extent2D);
    documentStructSize(types.Extent3D);
    documentStructSize(types.Rect2D);
    documentStructSize(types.Viewport);

    // Clear values
    documentStructSize(types.ClearColorValue);
    documentStructSize(types.ClearDepthStencilValue);
    documentStructSize(types.ClearValue);

    // Resource descriptions
    documentStructSize(types.ComponentMapping);
    documentStructSize(types.ImageSubresource);
    documentStructSize(types.ImageSubresourceRange);
    documentStructSize(types.ImageSubresourceLayers);

    // Vertex input
    documentStructSize(types.VertexInputAttributeDescription);
    documentStructSize(types.VertexInputBindingDescription);

    // Core structures
    documentStructSize(core_1_0.ApplicationInfo);
    documentStructSize(core_1_0.PhysicalDeviceLimits);
    documentStructSize(core_1_0.PhysicalDeviceProperties);
    documentStructSize(core_1_0.PhysicalDeviceFeatures);
    documentStructSize(core_1_0.QueueFamilyProperties);
    documentStructSize(core_1_0.MemoryType);
    documentStructSize(core_1_0.MemoryHeap);
    documentStructSize(core_1_0.DeviceQueueCreateInfo);
    documentStructSize(core_1_0.DeviceCreateInfo);

    // Memory
    documentStructSize(core_1_0.MemoryAllocateInfo);
    documentStructSize(types.MemoryRequirements);

    // Resources
    documentStructSize(core_1_0.BufferCreateInfo);
    documentStructSize(core_1_0.ImageCreateInfo);
    documentStructSize(core_1_0.ImageViewCreateInfo);
    documentStructSize(core_1_0.SamplerCreateInfo);

    // Command buffers
    documentStructSize(core_1_0.CommandPoolCreateInfo);
    documentStructSize(core_1_0.CommandBufferAllocateInfo);
    documentStructSize(core_1_0.CommandBufferBeginInfo);
    documentStructSize(core_1_0.CommandBufferInheritanceInfo);

    // Synchronization
    documentStructSize(core_1_0.FenceCreateInfo);
    documentStructSize(core_1_0.SemaphoreCreateInfo);
    documentStructSize(core_1_0.EventCreateInfo);
    documentStructSize(core_1_0.QueryPoolCreateInfo);

    // Submission
    documentStructSize(core_1_0.SubmitInfo);
    documentStructSize(core_1_0.MemoryBarrier);
    documentStructSize(core_1_0.BufferMemoryBarrier);
    documentStructSize(core_1_0.ImageMemoryBarrier);

    // Copy operations
    documentStructSize(core_1_0.BufferCopy);
    documentStructSize(core_1_0.ImageCopy);
    documentStructSize(core_1_0.BufferImageCopy);
    documentStructSize(core_1_0.ImageBlit);
    documentStructSize(core_1_0.ImageResolve);
    documentStructSize(core_1_0.ClearAttachment);
    documentStructSize(core_1_0.ClearRect);

    // Render pass
    documentStructSize(core_1_0.AttachmentDescription);
    documentStructSize(core_1_0.AttachmentReference);
    documentStructSize(core_1_0.SubpassDescription);
    documentStructSize(core_1_0.SubpassDependency);
    documentStructSize(core_1_0.RenderPassCreateInfo);
    documentStructSize(core_1_0.FramebufferCreateInfo);
    documentStructSize(core_1_0.RenderPassBeginInfo);

    // Pipeline
    documentStructSize(core_1_0.SpecializationMapEntry);
    documentStructSize(core_1_0.SpecializationInfo);
    documentStructSize(core_1_0.ShaderModuleCreateInfo);
    documentStructSize(core_1_0.PipelineShaderStageCreateInfo);
    documentStructSize(core_1_0.PipelineLayoutCreateInfo);
    documentStructSize(core_1_0.PushConstantRange);

    // Pipeline states
    documentStructSize(core_1_0.PipelineVertexInputStateCreateInfo);
    documentStructSize(core_1_0.PipelineInputAssemblyStateCreateInfo);
    documentStructSize(types.StencilOpState);
    documentStructSize(core_1_0.PipelineRasterizationStateCreateInfo);
    documentStructSize(core_1_0.PipelineMultisampleStateCreateInfo);
    documentStructSize(core_1_0.PipelineColorBlendAttachmentState);
    documentStructSize(core_1_0.PipelineColorBlendStateCreateInfo);
    documentStructSize(core_1_0.PipelineViewportStateCreateInfo);
    documentStructSize(core_1_0.PipelineTessellationStateCreateInfo);
    documentStructSize(core_1_0.PipelineDepthStencilStateCreateInfo);
    documentStructSize(core_1_0.PipelineDynamicStateCreateInfo);
    documentStructSize(core_1_0.GraphicsPipelineCreateInfo);

    // Descriptors
    documentStructSize(types.DescriptorSetLayoutBinding);
    documentStructSize(core_1_0.DescriptorPoolSize);
    documentStructSize(core_1_0.DescriptorSetLayoutCreateInfo);
    documentStructSize(core_1_0.DescriptorPoolCreateInfo);
    documentStructSize(core_1_0.DescriptorSetAllocateInfo);
    documentStructSize(core_1_0.DescriptorImageInfo);
    documentStructSize(core_1_0.DescriptorBufferInfo);
    documentStructSize(core_1_0.WriteDescriptorSet);
    documentStructSize(core_1_0.CopyDescriptorSet);
}

test "verify C ABI compliance" {
    std.log.info("=== C ABI COMPLIANCE VERIFICATION ===", .{});

    // Test critical structures individually to ensure C ABI compliance
    try testing.expect(verifyCABI(core_1_0.ApplicationInfo));
    try testing.expect(verifyCABI(core_1_0.PhysicalDeviceLimits));
    try testing.expect(verifyCABI(core_1_0.PhysicalDeviceProperties));
    try testing.expect(verifyCABI(core_1_0.DeviceCreateInfo));
    try testing.expect(verifyCABI(core_1_0.BufferCreateInfo));
    try testing.expect(verifyCABI(core_1_0.ImageCreateInfo));
    try testing.expect(verifyCABI(core_1_0.GraphicsPipelineCreateInfo));
    try testing.expect(verifyCABI(types.ClearValue));
    try testing.expect(verifyCABI(types.Viewport));
    try testing.expect(verifyCABI(core_1_0.SubmitInfo));

    std.log.info("✓ All critical structures are C ABI compliant", .{});
}

test "verify handle size consistency" {
    std.log.info("=== HANDLE SIZE CONSISTENCY ===", .{});

    const expected_handle_size = @sizeOf(types.Instance);

    // Verify all handles have consistent size
    try testing.expect(@sizeOf(types.Instance) == expected_handle_size);
    try testing.expect(@sizeOf(types.PhysicalDevice) == expected_handle_size);
    try testing.expect(@sizeOf(types.Device) == expected_handle_size);
    try testing.expect(@sizeOf(types.Queue) == expected_handle_size);
    try testing.expect(@sizeOf(types.CommandBuffer) == expected_handle_size);
    try testing.expect(@sizeOf(types.Semaphore) == expected_handle_size);
    try testing.expect(@sizeOf(types.Fence) == expected_handle_size);
    try testing.expect(@sizeOf(types.DeviceMemory) == expected_handle_size);
    try testing.expect(@sizeOf(types.Buffer) == expected_handle_size);
    try testing.expect(@sizeOf(types.Image) == expected_handle_size);
    try testing.expect(@sizeOf(types.ImageView) == expected_handle_size);
    try testing.expect(@sizeOf(types.Sampler) == expected_handle_size);
    try testing.expect(@sizeOf(types.DescriptorSet) == expected_handle_size);
    try testing.expect(@sizeOf(types.DescriptorSetLayout) == expected_handle_size);
    try testing.expect(@sizeOf(types.Pipeline) == expected_handle_size);
    try testing.expect(@sizeOf(types.PipelineLayout) == expected_handle_size);
    try testing.expect(@sizeOf(types.ShaderModule) == expected_handle_size);
    try testing.expect(@sizeOf(types.RenderPass) == expected_handle_size);
    try testing.expect(@sizeOf(types.Framebuffer) == expected_handle_size);
    try testing.expect(@sizeOf(types.QueryPool) == expected_handle_size);
    try testing.expect(@sizeOf(types.Event) == expected_handle_size);

    std.log.info("✓ All handles have consistent size: {} bytes", .{expected_handle_size});
}
