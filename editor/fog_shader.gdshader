shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest, repeat_enable;

uniform float epsilon = 0.1;
uniform vec2 fog_tiling = vec2(1.0,1.0);
uniform vec2 fog_offset_speed = vec2(0.01,0.01);
uniform sampler2D noise;

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	
	if ((COLOR-vec4(0.0,0.0,0.0,1.0)).r <= epsilon) {
		//COLOR = vec4(0.0,1.0,0.0,1.0);
		
		vec2 noise_uv = mod(UV * fog_tiling + fog_offset_speed * TIME,1.0);
		vec4 noise_tex = texture(noise, noise_uv);
		
		COLOR = noise_tex;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
