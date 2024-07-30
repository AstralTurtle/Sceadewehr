shader_type canvas_item;

uniform float radius = 1.;
uniform bool show = true;
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
	
	vec2 remouse = mouse_pos/652.*8.;
	float mouse_dist = ((1.-distance(remouse, recentered)/8.)-0.94)*20.;
	float dist2 = distance(remouse, a_center);
	float funny = (1.-(dist2*dist2*dist2))-0.5;
	vec3 added_color = mix(vec3(0.), vec3(0.3, 0.3, 1.), step(0.2, funny));
	COLOR = vec4(vec3(.5)+added_color, float(show)*funny);
}