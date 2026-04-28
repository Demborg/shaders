struct VertexInput {
    @location(0) pos: vec2f,
};

struct VertexOutput {
    @builtin(position) pos: vec4f,
};

struct FragmentInput {
    @builtin(position) pos: vec4f,
}

struct Complex {
    real: f32,
    imag: f32,
}

fn add(a: Complex, b: Complex) -> Complex {
    return Complex(
        a.real + b.real,
        a.imag + b.imag,
    );
}

fn sq(a: Complex) -> Complex {
    return Complex(
        a.real * a.real - a.imag * a.imag,
        2 * a.real * a.imag
    );
}

fn len(a: Complex) -> f32 {
    let s = sq(a);
    return s.real + s.imag;
}

fn mapToColor(a: f32) -> vec4f {
    return vec4f(
        a, a * a, a*a*a, 1
    );
}

@vertex
fn vertexMain(
    input: VertexInput
) -> VertexOutput {
    return VertexOutput(
        vec4f(input.pos, 0, 1),
    );
}

@fragment
fn fragmentMain(
    input: FragmentInput,
) -> @location(0) vec4f {
    let x = (input.pos.x - 750) / 500;
    let y = (input.pos.y - 500) / 500;

    let c = Complex(x, y);
    var z = Complex(0, 0);

    for (var i = 0; i < 1000; i++){
        z = add(sq(z), c);
        if len(z) > 4 {
            return mapToColor(f32(i) / 10.0);
        }        
    }
    return vec4f(0, 0, 0, 1);
}
