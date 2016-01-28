// Dimensions in m (SI)
length = 0.16;
height = 0.025;
thick  = 0.0092;

screw_pos = 0.0096;
screw_dia = 0.0045;

tab_height = 0.013;
tab_length = screw_pos * 2;
tab_round  = tab_height;

// real pin: d=0.0048 -> drill to fit
pin_dia   = 0.003;
pin_depth = 0.0164;
pin_back  = 0.009;

// Thickness to cut for easier sliding (0 for no cut)
thick_cut = 0.001;

// instantiate
include <chinook.scad>
chinook();