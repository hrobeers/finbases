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
chinook();

module chinook()
{
    difference()
    {
        base_cube(length);
        tab_cut();
        screw_cut();
        back_round_cut(length);
        pin_cut(length);
        thickness_cut(length, thick/2);
        thickness_cut(length, -thick/2);
    }
}

module base_cube(BaseLength)
{
    translate([0,0,-thick/2])
    cube(size=[height,
               BaseLength,
               thick],
         center=false);
}

module tab_cut()
{
    translate([tab_height,0,-thick/2*1.1])
    union()
    {
        translate([0,-thick,0])
        cube(size=[height,
                   tab_length+thick,
                   thick*1.1],
             center=false);
        translate([tab_round,tab_length,0])
        cylinder(h=thick*1.1,
                 r=tab_round,
                 center=false,
                 $fn=50);
    }
}

module screw_cut()
{
    translate([tab_height/2,screw_pos,0])
    rotate([0,90,0])
    cylinder(h=tab_height*1.1,
             d=screw_dia,
             center=true,
             $fn=50);
}

module back_round_cut(BaseLength)
{
    translate([height-tab_round,
               BaseLength-tab_round,
               -thick/2*1.1])
    difference()
    {
        cube(size=[tab_round*1.1,
                   tab_round*1.1,
                   thick*1.1],
             center=false);
        cylinder(h=thick*1.2,
                 r=tab_round,
                 center=false,
                 $fn=50);
    }
}

module pin_cut(BaseLength)
{
    translate([pin_depth,
               BaseLength-pin_back,
               0])
    rotate([0,0,0])
    cylinder(h=tab_height*1.1,
             d=pin_dia,
             center=true,
             $fn=50);
}

module thickness_cut(BaseLength, zOffset)
{
    translate([pin_depth,
               BaseLength-pin_back,
               zOffset])
    rotate([0,0,45])
    cube(size=[pin_depth*2.2,
               height*3,
               thick_cut],
         center=true);
}
