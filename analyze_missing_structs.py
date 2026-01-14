#!/usr/bin/env python3

# Complete VkStructureType values from Vulkan 1.3 specification
VK_STRUCTURE_TYPES = {
    "application_info": 0,
    "instance_create_info": 1,
    "device_queue_create_info": 2,
    "device_create_info": 3,
    "submit_info": 4,
    "memory_allocate_info": 5,
    "mapped_memory_range": 6,
    "bind_sparse_info": 7,
    "fence_create_info": 8,
    "semaphore_create_info": 9,
    "event_create_info": 10,
    "query_pool_create_info": 11,
    "buffer_create_info": 12,
    "buffer_view_create_info": 13,
    "image_create_info": 14,
    "image_view_create_info": 15,
    "shader_module_create_info": 16,
    "pipeline_cache_create_info": 17,
    "pipeline_shader_stage_create_info": 18,
    "pipeline_vertex_input_state_create_info": 19,
    "pipeline_input_assembly_state_create_info": 20,
    "pipeline_tessellation_state_create_info": 21,
    "pipeline_viewport_state_create_info": 22,
    "pipeline_rasterization_state_create_info": 23,
    "pipeline_multisample_state_create_info": 24,
    "pipeline_depth_stencil_state_create_info": 25,
    "pipeline_color_blend_state_create_info": 26,
    "pipeline_dynamic_state_create_info": 27,
    "graphics_pipeline_create_info": 28,
    "compute_pipeline_create_info": 29,
    "pipeline_layout_create_info": 30,
    "sampler_create_info": 31,
    "descriptor_set_layout_create_info": 32,
    "descriptor_pool_create_info": 33,
    "descriptor_set_allocate_info": 34,
    "write_descriptor_set": 35,
    "copy_descriptor_set": 36,
    "framebuffer_create_info": 37,
    "render_pass_create_info": 38,
    "command_pool_create_info": 39,
    "command_buffer_allocate_info": 40,
    "command_buffer_inheritance_info": 41,
    "command_buffer_begin_info": 42,
    "render_pass_begin_info": 43,
    "buffer_memory_barrier": 44,
    "image_memory_barrier": 45,
    "memory_barrier": 46,
    "loader_instance_create_info": 47,
    "loader_device_create_info": 48,
    "physical_device_subgroup_properties": 1000094000,
    "bind_buffer_memory_info": 1000157000,
    "bind_image_memory_info": 1000157001,
    "physical_device_16bit_storage_features": 1000083000,
    "memory_dedicated_requirements": 1000127000,
    "memory_dedicated_allocate_info": 1000127001,
    "memory_allocate_flags_info": 1000060000,
    "device_group_render_pass_begin_info": 1000060003,
    "device_group_command_buffer_begin_info": 1000060004,
    "device_group_submit_info": 1000060005,
    "device_group_bind_sparse_info": 1000060006,
    "bind_buffer_memory_device_group_info": 1000060013,
    "bind_image_memory_device_group_info": 1000060014,
    "physical_device_group_properties": 1000070000,
    "device_group_device_create_info": 1000070001,
    "physical_device_features_2": 1000059000,
    "physical_device_properties_2": 1000059001,
    "format_properties_2": 1000059002,
    "image_format_properties_2": 1000059003,
    "queue_family_properties_2": 1000059004,
    "physical_device_memory_properties_2": 1000059005,
    "sparse_image_format_properties_2": 1000059006,
    "physical_device_sparse_image_format_info_2": 1000059007,
    "command_buffer_inheritance_conditional_rendering_info_ext": 1000081000,
    "external_memory_image_create_info": 1000072000,
    "external_memory_buffer_create_info": 1000072001,
    "export_memory_allocate_info": 1000072002,
    "physical_device_external_image_format_info": 1000071000,
    "external_image_format_properties": 1000071001,
    "physical_device_external_buffer_info": 1000071002,
    "external_buffer_properties": 1000071003,
    "physical_device_id_properties": 1000071004,
    "physical_device_external_fence_info": 1000112000,
    "external_fence_properties": 1000112001,
    "physical_device_external_semaphore_info": 1000076000,
    "external_semaphore_properties": 1000076001,
    "physical_device_shader_draw_parameters_features": 1000063000,
    "physical_device_vulkan_1_1_features": 49,
    "physical_device_vulkan_1_1_properties": 50,
    "physical_device_vulkan_1_2_features": 51,
    "physical_device_vulkan_1_2_properties": 52,
    "semaphore_type_create_info": 1000207002,
    "timeline_semaphore_submit_info": 1000207003,
    "semaphore_wait_info": 1000207004,
    "semaphore_signal_info": 1000207005,
    "device_memory_opaque_capture_address_info": 1000257004,
    "buffer_device_address_info": 1000244001,
    "render_pass_create_info_2": 1000109004,
    "subpass_begin_info": 1000109005,
    "subpass_end_info": 1000109006,
    "physical_device_tool_properties": 1000245000,
    "physical_device_shader_terminate_invocation_features": 1000215000,
    "physical_device_private_data_features": 1000295000,
    "physical_device_shader_integer_dot_product_features": 1000280000,
    "physical_device_texel_buffer_alignment_properties": 1000281001,
    "physical_device_vulkan_1_3_properties": 54,
    "swapchain_create_info_khr": 1000001000,
    "present_info_khr": 1000001001,
    "wayland_surface_create_info_khr": 1000006000,
    "win32_surface_create_info_khr": 1000009000,
    "xlib_surface_create_info_khr": 1000004000,
    "xcb_surface_create_info_khr": 1000005000,
    "android_surface_create_info_khr": 1000008000,
    "debug_report_callback_create_info_ext": 1000011000,
}

print(f"Total VkStructureType values: {len(VK_STRUCTURE_TYPES)}")

# Extract implemented structs from the codebase
import os
import subprocess

def find_implemented_structs():
    """Find all struct definitions in the codebase"""
    structs = set()
    
    # Get all struct definitions
    result = subprocess.run([
        'grep', '-h', 'pub const.*= extern struct', 
        '/home/felixuxx/Projects/gamedev/zvulkan-bindings/src/vulkan/*.zig',
        '/home/felixuxx/Projects/gamedev/zvulkan-bindings/src/vulkan/extensions/*.zig'
    ], capture_output=True, text=True)
    
    for line in result.stdout.strip().split('\n'):
        if line:
            # Extract struct name: "pub const StructName = extern struct"
            parts = line.split(' ')
            if len(parts) >= 4:
                struct_name = parts[2]
                structs.add(struct_name)
    
    return structs

def snake_to_pascal(snake_str):
    """Convert snake_case to PascalCase"""
    parts = snake_str.split('_')
    return ''.join(word.capitalize() for word in parts)

def categorize_struct(struct_name, value):
    """Categorize missing structs by priority"""
    # Critical core structures (0-46)
    if 0 <= value <= 46:
        # Skip loader-specific structures
        if value in [47, 48]:
            return "IGNORED"
        return "CRITICAL"
    
    # Important core 1.1-1.3 structures (49, 50, 51, 52, 54)
    if value in [49, 50, 51, 52, 54]:
        return "IMPORTANT"
    
    # WSI and important extensions
    if any(struct_name.startswith(prefix) for prefix in [
        "swapchain_", "present_", "wayland_", "win32_", "xlib_", 
        "xcb_", "android_", "debug_report_"
    ]):
        return "EXTENSIONS"
    
    # Core memory management and synchronization
    if any(struct_name.startswith(prefix) for prefix in [
        "bind_", "memory_", "external_", "semaphore_", "render_pass_2", 
        "subpass_", "device_group_"
    ]):
        return "IMPORTANT"
    
    # Advanced features
    return "ADVANCED"

def main():
    print("=== VULKAN STRUCTS COMPLETENESS ANALYSIS ===")
    print()
    
    implemented_structs = find_implemented_structs()
    print(f"Found {len(implemented_structs)} implemented structs")
    
    total_structs = len(VK_STRUCTURE_TYPES)
    implemented_count = 0
    missing_by_priority = {}
    
    print("\nMISSING STRUCTURES BY PRIORITY:")
    print("================================")
    
    # Check each structure type
    for struct_name, value in sorted(VK_STRUCTURE_TYPES.items(), key=lambda x: x[1]):
        pascal_name = snake_to_pascal(struct_name)
        
        if pascal_name in implemented_structs:
            implemented_count += 1
        else:
            priority = categorize_struct(struct_name, value)
            if priority != "IGNORED":
                if priority not in missing_by_priority:
                    missing_by_priority[priority] = []
                missing_by_priority[priority].append((pascal_name, value, struct_name))
    
    # Print missing structures by priority
    for priority in ["CRITICAL", "IMPORTANT", "EXTENSIONS", "ADVANCED"]:
        if priority in missing_by_priority:
            print(f"\n{priority} MISSING STRUCTURES:")
            print("-" * (len(priority) + 18))
            for pascal_name, value, snake_name in sorted(missing_by_priority[priority], key=lambda x: x[1]):
                print(f"  {pascal_name:<50} (value: {value}) - {snake_name}")
    
    # Summary statistics
    missing_count = total_structs - implemented_count
    completeness_percentage = (implemented_count / total_structs) * 100
    
    print(f"\n=== SUMMARY STATISTICS ===")
    print(f"Total Vulkan 1.3 structures: {total_structs}")
    print(f"Implemented structures: {implemented_count} ({completeness_percentage:.1f}%)")
    print(f"Missing structures: {missing_count} ({100-completeness_percentage:.1f}%)")
    print()
    
    print("Missing by priority:")
    for priority in ["CRITICAL", "IMPORTANT", "EXTENSIONS", "ADVANCED"]:
        count = len(missing_by_priority.get(priority, []))
        print(f"  {priority.lower():<11}: {count}")
    
    print(f"\n=== PRODUCTION READINESS ASSESSMENT ===")
    if completeness_percentage >= 90:
        print(f"EXCELLENT: {completeness_percentage:.1f}% complete - Ready for production")
    elif completeness_percentage >= 75:
        print(f"GOOD: {completeness_percentage:.1f}% complete - Nearly production ready")
    elif completeness_percentage >= 50:
        print(f"FAIR: {completeness_percentage:.1f}% complete - Needs significant work")
    else:
        print(f"POOR: {completeness_percentage:.1f}% complete - Requires major development")

if __name__ == "__main__":
    main()
