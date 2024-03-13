RSRC                    ShaderMaterial            ��������                                            .      resource_local_to_scene    resource_name    code    script    interpolation_mode    interpolation_color_space    offsets    colors    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    shader    shader_parameter/epsilon    shader_parameter/fog_tiling "   shader_parameter/fog_offset_speed    shader_parameter/noise           local://Shader_n7l1i �         local://Gradient_63yys C         local://FastNoiseLite_0subw �         local://NoiseTexture2D_q08kx �         local://ShaderMaterial_qnksc )	         Shader          9  shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest, repeat_enable;

uniform float epsilon = 0.1;
uniform vec2 fog_tiling = vec2(1.0,1.0);
uniform vec2 fog_offset_speed = vec2(0.01,0.01);
uniform sampler2D noise;

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	
	// If pixel color is sufficiently black: make it foggy
	if ((COLOR-vec4(0.0,0.0,0.0,1.0)).r <= epsilon) {
		//COLOR = vec4(0.0,1.0,0.0,1.0); //to better see which pixels are affected
		
		vec2 noise_uv = mod(UV * fog_tiling + fog_offset_speed * TIME,1.0);
		vec4 noise_tex = texture(noise, noise_uv);
		
		COLOR = noise_tex;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
       	   Gradient       !      @��>  �?   $                    �?��=�=��=  �?         FastNoiseLite                                        NoiseTexture2D    "         '            (                     ShaderMaterial    )             *   )   ���Q��?+   
     �@  �@,   
   
�#<
�#<-                  RSRC