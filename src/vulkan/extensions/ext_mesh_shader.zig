//! VK_EXT_mesh_shader extension
//! Next-generation geometry processing

const types = @import("../types.zig");
const constants = @import("../constants.zig");

pub const EXT_MESH_SHADER_EXTENSION_NAME = "VK_EXT_mesh_shader";

// ============================================================================
// Enums
// ============================================================================

pub const ShaderStageFlagsEXT = types.ShaderStageFlagsEXT;

// ============================================================================
// Structures
// ============================================================================

pub const PhysicalDeviceMeshShaderFeaturesEXT = extern struct {
    s_type: types.StructureType = .physical_device_mesh_shader_features_ext,
    p_next: ?*const anyopaque = null,
    task_shader: types.Bool32 = 0,
    mesh_shader: types.Bool32 = 0,
    multiview_mesh_shader: types.Bool32 = 0,
    primitive_fragment_shading_rate_mesh_shader: types.Bool32 = 0,
    mesh_shader_queries: types.Bool32 = 0,
};

pub const PhysicalDeviceMeshShaderPropertiesEXT = extern struct {
    s_type: types.StructureType = .physical_device_mesh_shader_properties_ext,
    p_next: ?*anyopaque = null,
    max_task_work_group_total_count: u32,
    max_task_work_group_count: [3]u32,
    max_task_work_group_invocations: u32,
    max_task_work_group_size: [3]u32,
    max_task_payload_size: u32,
    max_task_shared_memory_size: u32,
    max_task_payload_and_shared_memory_size: u32,
    max_mesh_work_group_total_count: u32,
    max_mesh_work_group_count: [3]u32,
    max_mesh_work_group_invocations: u32,
    max_mesh_work_group_size: [3]u32,
    max_mesh_shared_memory_size: u32,
    max_mesh_payload_and_shared_memory_size: u32,
    max_mesh_output_memory_size: u32,
    max_mesh_payload_and_output_memory_size: u32,
    max_mesh_output_components: u32,
    max_mesh_output_vertices: u32,
    max_mesh_output_primitives: u32,
    max_mesh_output_layers: u32,
    max_mesh_multiview_view_count: u32,
    mesh_output_per_vertex_granularity: u32,
    mesh_output_per_primitive_granularity: u32,
    max_preferred_task_work_group_invocations: u32,
    max_preferred_mesh_work_group_invocations: u32,
    prefers_local_invocation_vertex_output: types.Bool32,
    prefers_local_invocation_primitive_output: types.Bool32,
    prefers_compact_vertex_output: types.Bool32,
    prefers_compact_primitive_output: types.Bool32,
};

pub const DrawMeshTasksIndirectCommandEXT = extern struct {
    group_count_x: u32,
    group_count_y: u32,
    group_count_z: u32,
};
