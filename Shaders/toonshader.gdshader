shader_type spatial;
render_mode blend_mix, depth_prepass_alpha, cull_disabled, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D albedo       : source_color;
uniform float shadow_threshold : hint_range(0.0, 1.0) = 0.30;

void fragment() {
	ALBEDO = texture(albedo,UV).rgb;
}

void light() {
		// basic light
	float base_light = clamp(dot(NORMAL, LIGHT), 0.0, 1.0) * ATTENUATION;

	// all threshholds
	bool shadow = base_light >= shadow_threshold;

	// shadow output
	DIFFUSE_LIGHT = vec3(shadow ? 1.0 : 0.0);

}
