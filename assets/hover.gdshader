shader_type canvas_item;

uniform float radius = 1.;
uniform vec2 mouse_pos;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float divisions = 8.;
	vec2 recentered = (UV)*divisions;
	vec2 a_center = vec2(float(int(recentered.x)), float(int(recentered.y)));
	a_center.x += .5;
	a_center.y += .5;
	float dist = (distance(recentered, a_center)/divisions-radius/100.);
	float feathered = 1.-smoothstep(0., 0.01, dist);
	
	vec2 remouse = mouse_pos/600.*8.;
	float mouse_dist = ((1.-distance(remouse, recentered)/8.)-0.94)*20.;
	//COLOR = vec4(vec3(.2, .4, .6), feathered/10. + mix(0.0, 1.5, mouse_dist*feathered));
	COLOR = vec4(vec3(.2, .4, .6), max(5.*feathered*mouse_dist, 0.) + feathered/5.);
	//COLOR = vec4(vec3(mouse_dist), 1.);
}