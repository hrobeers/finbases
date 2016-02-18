module round_cut(radius, height)
{
    translate([0,0,-height*0.05])
    difference()
    {
        cube(size=[radius*1.1,
                   radius*1.1,
                   height*1.1],
             center=false);
        cylinder(h=height*1.1,
                 r=radius,
                 center=false);
    }
}