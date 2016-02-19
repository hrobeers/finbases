module chinook(length)
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

module finfit(base_length, mirror_vec)
{
    front_offset = tab_length;
    length = base_length + tab_length;
    mirror(mirror_vec)
    translate([0,-front_offset, 0])
    chinook(length);
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
                 center=false);
    }
}

module screw_cut()
{
    translate([tab_height/2,screw_pos,0])
    rotate([0,90,0])
    cylinder(h=tab_height*1.1,
             d=screw_dia,
             center=true);
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
                 center=false);
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
             center=true);
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
