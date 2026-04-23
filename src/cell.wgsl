struct VertexInput {
    @location(0) pos: vec2f,
    @builtin(instance_index) instance: u32,
};

struct VertexOutput {
    @builtin(position) pos: vec4f,
    @location(0) cell: vec2f,
};

struct FragmentInput {
    @location(0) cell: vec2f,
}

@group(0) @binding(0) var<uniform> grid: vec2f;

@vertex
fn vertexMain(
    input: VertexInput
) -> VertexOutput {
    let i = f32(input.instance);
    let cell = vec2f(i % grid.x, floor(i / grid.x));
    let cellOffset = cell / grid * 2;
    let gridPos = (input.pos + 1) / grid - 1 + cellOffset;

    return VertexOutput(
        vec4f(gridPos, 0, 1),
        cell,
    );
}

@fragment
fn fragmentMain(
    input: FragmentInput,
) -> @location(0) vec4f {
  return vec4f(input.cell / grid, 1, 1);
}
