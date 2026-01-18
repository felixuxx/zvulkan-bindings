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
    p_next: ?*const anyopaque = null,
    max_draw_mesh_tasks_count: u32 = 0,
    max_task_work_group_invocations: u32 = 0,
    max_task_work_group_size: u32 = 0,
    max_task_payload_size: u32 = 0,
    max_mesh_work_group_invocations: u32 = 0,
    max_mesh_work_group_size: u32 = 0,
    max_mesh_payload_size: u32 = 0,
    max_mesh_output_components: u32 = 0,
    max_mesh_output_vertices: u32 = 0,
    max_mesh_output_primitives: u32 = 0,
    max_mesh_multiview_view_count: u32 = 0,
    mesh_output_per_vertex_granularity: u32 = 0,
    max_mesh_output_per_primitive_granularity: u32 = 0,
    maxPreferredWorkGroupMultiple: u32 = 0,
};

pub const DrawMeshTasksIndirectCommandEXT = extern struct {
    task_count: u32,
    first_task: u32,
};

pub const DrawMeshTasksIndirectCountCommandEXT = extern struct {
    task_count: u32,
    first_task: u32,
    task_count_multiplier: u32 = 1,
};
