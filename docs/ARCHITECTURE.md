# Architecture

`zvulkan-bindings` is designed to be a lightweight, zero-dependency layer between Zig code and the Vulkan dynamic library (`libvulkan.so`, `vulkan-1.dll`, etc.).

## Directory Structure

```bash
src/
├── root.zig            # Main module export
├── main.zig            # Example usage / Test executable
└── vulkan/
    ├── types.zig       # Base types, enums, flags, handles
    ├── constants.zig   # API constants (versions, max limits)
    ├── platform.zig    # OS-specific dynamic library loading (dlopen/LoadLibrary)
    ├── vk.zig          # The Loader and Dispatch Tables
    ├── core_1_0.zig    # Vulkan 1.0 specific structures
    ├── core_1_1.zig    # Vulkan 1.1 specific structures
    ├── core_1_2.zig    # Vulkan 1.2 specific structures
    ├── core_1_3.zig    # Vulkan 1.3 specific structures
    └── extensions/     # WSI and other extensions
```

## Loader Design

The loader architecture avoids linking against Vulkan at compile time. Instead, it loads the library at runtime.

### 1. The `Loader` Struct (`src/vulkan/vk.zig`)

This is the entry point. When initialized, it:

1. Detects the OS.
2. Calls `platform.openLibrary()` to find the Vulkan shared object.
3. Loads the fundamental bootstrap function: `vkGetInstanceProcAddr`.
4. Uses this bootstrap function to load global commands like `vkCreateInstance` and `vkEnumerateInstanceExtensionProperties`.

### 2. Dispatch Tables

Vulkan function pointers are stored in dispatch tables to avoid the overhead of calling the loader for every single command (trampoline overhead). We have two levels of dispatch:

* **InstanceDispatch**: Contains functions that operate on an `Instance` or `PhysicalDevice`. Created via `Loader.createInstanceDispatch(instance)`.
* **DeviceDispatch**: Contains functions that operate on a `Device`, `Queue`, or `CommandBuffer`. Created via `Loader.createDeviceDispatch(device)`.

These tables are manually populated using `vkGetInstanceProcAddr` and `vkGetDeviceProcAddr`.

### 3. Modular Versioning

Unlike a monolithic C header, the API is split by version.

* `core_1_0` contains the foundational API.
* `core_1_1` through `core_1_3` contain **only** the delta added in those versions.
* The Dispatch structs in `vk.zig` aggregates these. Newer core functions (1.1+) are loaded as **Optionals** (`?*const fn...`). This allows the code to run on drivers that do not support the latest version, provided you check for `null` before calling.

## Type System

We aim for binary compatibility with C, but with Zig's safety features:

* **Enums**: Used for `VkStructureType`, `VkResult`, etc.
* **Packed Structs**: Used for Bitmasks (Flags). This ensures `MyFlags.texture_bit` works naturally without manual bitwise operators.
* **Extern Structs**: Used for all Vulkan Data Structures to ensure C ABI compatibility.
* **Optional Pointers**: `?*T` is used where Vulkan allows `NULL`.

## Extension Handling

Extensions are isolated in `src/vulkan/extensions/`. To use an extension:

1. Import the extension module.
2. The `InstanceDispatch` and `DeviceDispatch` tables have reserved slots for common WSI extension functions (`vkCreateSwapchainKHR`, etc.) which are loaded if the extension was enabled during instance/device creation.
