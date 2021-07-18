//Generated for GMS2 in Geon FX v1.2.4
//Put this code in Create event

//NewEffect Particle System
ps = part_system_create();
part_system_depth(ps, -1);

//NewEffect Particle Types
//Effect1
pt_Effect1 = part_type_create();
part_type_shape(pt_Effect1, pt_shape_flare);
part_type_size(pt_Effect1, 0.50, 0.50, 0, 0.50);
part_type_scale(pt_Effect1, 1, 1);
part_type_orientation(pt_Effect1, 0, 360, 0, 0, 0);
part_type_color3(pt_Effect1, 7434751, 255, 255);
part_type_alpha3(pt_Effect1, 1, 0.6, 0);
part_type_blend(pt_Effect1, 0);
part_type_life(pt_Effect1, 15, 22);
part_type_speed(pt_Effect1, 0, 2, 0, 0);
part_type_direction(pt_Effect1, 0, 360, 0, 0);
part_type_gravity(pt_Effect1, 0, 0);

//NewEffect Emitters
pe_Effect1 = part_emitter_create(ps);

//NewEffect emitter positions. Streaming or Bursting Particles.
part_emitter_burst(ps, pe_Effect1, pt_Effect1, 5);
part_emitter_region(ps, pe_Effect1, -20, +20, -20, +20, ps_shape_ellipse, ps_distr_gaussian);

//Destroying Emitters
//part_emitter_destroy(ps, pe_Effect1);

alarm[0] = SEC/2