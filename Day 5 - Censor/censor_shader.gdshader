shader_type spatial;
render_mode unshaded;

uniform int pixel_size : hint_range(0, 256); // Adjust the pixel size as needed
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	
	int even_pixel_size = pixel_size - (pixel_size % 2);
	
	// Get nearest neighbor
	float x = float(int(FRAGCOORD.x) % even_pixel_size);
	float y = float(int(FRAGCOORD.y) % even_pixel_size);

	x = FRAGCOORD.x + floor(float(even_pixel_size) / 2.0) - x;
	y = FRAGCOORD.y + floor(float(even_pixel_size) / 2.0) - y;
	
	// Sample Screen Texture with new position
	ALBEDO = texture(SCREEN_TEXTURE, vec2(x, y) / VIEWPORT_SIZE).xyz;
}