# Contributing to zvulkan-bindings

Thank you for your interest in contributing to `zvulkan-bindings`!
We welcome contributions that help improve the completeness, modularity,
and correctness of these bindings.

## Project Philosophy

This project aims to provide **idiomatic**, **modular**, and **zero-dependency**
bindings for Vulkan in Zig.

1. **Zero Dependencies**: We do not use C headers or build-time generators.
All code must be pure Zig.
2. **Explicit Modularity**: Core versions (1.0, 1.1, etc.) and extensions live
in separate files.
3. **Type Safety**: Use Zig enums and packed structs where possible,
but maintain exact binary compatibility with the Vulkan C API.

## How to Contribute

### 1. Adding Extensions

Vulkan has many extensions. If you need one that isn't implemented:

1. Create a new file in `src/vulkan/extensions/` (e.g., `ext_debug_utils.zig`).
2. Define the structs, enums, and function pointer types for that extension.
3. Add the extension function pointers to `InstanceDispatch` or `DeviceDispatch`
in `src/vulkan/vk.zig` as optional fields (initialized to `null` or loaded via
`loadOptional...`).
4. Export the module in `src/root.zig`.

### 2. Implementing Core Features

If you find missing structs or functions in the Core modules (`core_1_X.zig`):

1. Verify the struct layout against the [Vulkan Specification](https://registry.khronos.org/vulkan/specs/1.3-extensions/html/vkspec.html).
2. Add the missing types to `src/vulkan/types.zig` or the specific core module.
3. Add missing function pointers to the dispatch tables in `vk.zig`.

### 3. Code Style

* Use `zig fmt` to format your code.
* Snake_case for function names and variable names.
* CamelCase for structs and enums.
* Use `callconv(.c)` for all Vulkan function pointer definitions.

## Testing

Ensure the project compiles and runs with:

```bash
zig build
zig build run
```

If adding new features, please add a small runtime check in `src/main.zig`
(or a dedicated test file) to verify that the new types/functions can be
used correctly.
