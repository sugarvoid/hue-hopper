shader_type canvas_item;

uniform bool is_active = true;
//uniform vec4 flash_color : hint_color = vec4(1.0);
//uniform float flash_modifer : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 white_color = vec4(1.0, 1.0, 1.0, previous_color.a);
	vec4 new_color = previous_color;
	if (is_active) {
		new_color = white_color;
	}
	//color.rgb = mix(color.rgb, flash_color.rgb, flash_modifer);
	COLOR = new_color;
}