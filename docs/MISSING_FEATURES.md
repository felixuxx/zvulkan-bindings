# Missing Features and Known Limitations

While `zvulkan-bindings` is capable of powering a modern game engine, it is not a 1:1 reflection of the entire Vulkan Specification registry.

## 1. No Auto-Generation (XML Registry)

This project is **hand-written**. It does NOT parse `vk.xml` to generate bindings.

* **Pros**: Cleaner, human-readable code; faster compile times; no Python/XML dependencies.
* **Cons**: New Vulkan versions require manual updates. Extensions are added on an "as-needed" basis.

## 2. Missing Extensions

Only the Core API (1.0 - 1.3) and Window System Integration (WSI) extensions are currently implemented.

**Notable Missing Extensions:**

* `VK_EXT_debug_utils`: Useful for verification and object naming (though validation layers can still be enabled via `InstanceCreateInfo`).
* `VK_KHR_acceleration_structure` / `VK_KHR_ray_tracing_pipeline`: Ray Tracing support.
* `VK_EXT_mesh_shader`: Mesh Shaders.
* `VK_KHR_video_queue`: Video encode/decode.

*If you need these, please see `CONTRIBUTING.md` to add them.*

## 3. Now Implemented ✅

**Graphics Pipeline Support:** As of the latest update, all core graphics pipeline creation structures are now implemented:

- ✅ `VkPipelineVertexInputStateCreateInfo`
- ✅ `VkPipelineInputAssemblyStateCreateInfo` 
- ✅ `VkPipelineRasterizationStateCreateInfo`
- ✅ `VkPipelineMultisampleStateCreateInfo`
- ✅ `VkPipelineColorBlendAttachmentState`
- ✅ `VkPipelineColorBlendStateCreateInfo`
- ✅ `VkGraphicsPipelineCreateInfo`
- ✅ `VkPipelineViewportStateCreateInfo`
- ✅ `VkPipelineDepthStencilStateCreateInfo`
- ✅ `VkPipelineDynamicStateCreateInfo`
- ✅ `VkPipelineTessellationStateCreateInfo`
- ✅ `vkCreateGraphicsPipelines` & `vkDestroyPipeline` functions

This enables complete graphics pipeline creation for rendering applications.

## 3. Allocator Integration

The API currently uses raw pointers (`?[*]const T`, `?*const T`) to match the C ABI exactly.
There are no higher-level wrappers that automatically use Zig's `std.mem.Allocator` to manage `pNext` chains or array allocations. You must manage memory yourself, just like in C.

## 4. Validation Layer Helpers

There is no helper function to automatically setup the `vkDebugUtilsMessengerEXT` callback. You must manually populate the struct in the `pNext` chain of `InstanceCreateInfo` if you want to capture validation messages programmatically at startup.

## 5. Global Function Loading

We do not support strictly "statically linked" Vulkan (linking `libvulkan.so` at compile time). We enforce dynamic loading via `dlopen`/`LoadLibrary`. This is generally considered best practice for distributing games, but it is a limitation if you specifically wanted static linking.
