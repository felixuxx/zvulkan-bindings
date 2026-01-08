//! Platform-specific dynamic library loading for Vulkan
//! Supports Linux, Windows, and macOS without external dependencies

const std = @import("std");
const builtin = @import("builtin");

pub const LibraryHandle = if (builtin.os.tag == .windows)
    std.os.windows.HMODULE
else
    *anyopaque;

pub const LoadError = error{
    LibraryNotFound,
    SymbolNotFound,
};

/// Load the Vulkan shared library
pub fn loadVulkanLibrary() LoadError!LibraryHandle {
    switch (builtin.os.tag) {
        .linux, .freebsd, .openbsd, .netbsd => {
            // Try common library names on Unix-like systems
            const lib_names = [_][:0]const u8{
                "libvulkan.so.1",
                "libvulkan.so",
            };

            for (lib_names) |name| {
                const handle = std.c.dlopen(name, @bitCast(@as(u32, 0x00001))); // RTLD_LAZY
                if (handle) |h| return h;
            }
            return LoadError.LibraryNotFound;
        },
        .windows => {
            const kernel32 = std.os.windows.kernel32;
            const handle = kernel32.LoadLibraryA("vulkan-1.dll");
            if (handle) |h| return h;
            return LoadError.LibraryNotFound;
        },
        .macos => {
            const lib_names = [_][:0]const u8{
                "libvulkan.1.dylib",
                "libvulkan.dylib",
                "libMoltenVK.dylib",
            };

            for (lib_names) |name| {
                const handle = std.c.dlopen(name, @bitCast(@as(u32, 0x00001))); // RTLD_LAZY
                if (handle) |h| return h;
            }
            return LoadError.LibraryNotFound;
        },
        else => @compileError("Unsupported platform for Vulkan bindings"),
    }
}

/// Get a function pointer from the loaded library
pub fn getSymbol(handle: LibraryHandle, name: [:0]const u8) ?*anyopaque {
    switch (builtin.os.tag) {
        .linux, .freebsd, .openbsd, .netbsd, .macos => {
            return std.c.dlsym(handle, name);
        },
        .windows => {
            const kernel32 = std.os.windows.kernel32;
            return kernel32.GetProcAddress(handle, name);
        },
        else => @compileError("Unsupported platform for Vulkan bindings"),
    }
}

/// Unload the Vulkan library
pub fn unloadLibrary(handle: LibraryHandle) void {
    switch (builtin.os.tag) {
        .linux, .freebsd, .openbsd, .netbsd, .macos => {
            _ = std.c.dlclose(handle);
        },
        .windows => {
            const kernel32 = std.os.windows.kernel32;
            _ = kernel32.FreeLibrary(handle);
        },
        else => @compileError("Unsupported platform for Vulkan bindings"),
    }
}
