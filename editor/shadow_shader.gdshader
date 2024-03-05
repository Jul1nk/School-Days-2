shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

uniform sampler2D noise;
uniform float distortion_intensity = 0.1;

uniform vec2 distortion_tiling = vec2(1.0,1.0);
uniform vec2 distortion_offset_speed;

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	
	if (COLOR == vec4(0.0,0.0,0.0,1.0)) {
		//COLOR = vec4(0.0,1.0,0.0,1.0);
		
		vec2 base_uv = UV;
		
		vec2 noise_uv = UV * distortion_tiling + distortion_offset_speed * TIME;
		vec4 noise_tex = texture(noise, noise_uv);
		
		COLOR = noise_tex;
		
		
		//COLOR = noise_tex;
		//
		//vec2 distortion_uv = base_uv + noise_tex * distortion_intensity;
		//
		//vec4 albedo_tex = texture(screen_texture, distortion_uv);
		//albedo_tex *= COLOR;
		//COLOR = albedo_tex;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
