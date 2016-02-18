// Dimensions in m (SI)
top_length   = 0.146;
bot_length   = 0.156;
front_height = 0.05;
back_height  = 0.036;
thick        = 0.015;

front_angle = 95;
back_angle  = 105;

round_radius = 0.0045;

drill_depth = 0.03;
drill_dia   = 0.007;
drill_dist  = 0.019;

// face resolution for curved surfaces
$fn=20;

// instantiate
tuttle();

module tuttle()
{
    difference()
    {
        base_shape();
        base_cut();
        front_cut();
        back_cut();
    }
}

module base_shape()
{
    rotate([0,0,rot_angle()])
    translate([0,0,-thick/2])
    difference() {
    union()
    {
        cube(size=[height(),
                   top_length,
                   thick],
             center=false);

        translate([height(),0,0])
        rotate([0,0,front_angle])
        cube(size=[0.02,
                   front_height,
                   thick],
             center=false);

        translate([height(),
                   top_length,
                   0])
        mirror([0,1,0])
        rotate([0,0,back_angle])
        cube(size=[0.02,
                   front_height,
                   thick],
             center=false);
    }
        drill_holes();
    }
}

module drill_holes()
{
    union()
    {
        drill_hole(drill_dist);
        drill_hole(top_length-drill_dist);
    }
}

module drill_hole(FrontDistance)
{
    translate([vert_front_h()-drill_depth,
               FrontDistance,
               thick/2])
    rotate([0,90,0])
    cylinder(h=drill_depth*1.1,
             d=drill_dia,
             center = false);
}

module base_cut()
{
    translate([-0.02,
               -back_height,
               -thick*1.1/2])
    cube(size=[0.02,
               back_height*6,
               thick*1.1],
         center=false);
}

module back_cut()
{
    rotate([0,0,rot_angle()])
    translate([0,0,-thick/2])

    translate([height()*1.02,
               top_length,
               0])
    mirror([0,1,0])
    rotate([0,0,back_angle])
    rounding_cuts();
}

module front_cut()
{
    rotate([0,0,rot_angle()])
    translate([0,0,-thick/2])

    translate([height(),0,0])
    rotate([0,0,front_angle])
    rounding_cuts();
}

use <../lib/round_cut.scad>
module rounding_cuts()
{
    union()
    {
        translate([round_radius,
                   front_height*1.05,
                   thick-round_radius])
        rotate([90,-90,0])
        round_cut(round_radius, front_height);

        translate([round_radius,
                   front_height*1.05,
                   round_radius])
        rotate([90,180,0])
        round_cut(round_radius, front_height);

        translate([round_radius,
                   round_radius/1.1,
                   0])
        rotate([0,0,180])
        round_cut(round_radius, thick);
    }
}


function rot_angle() =
    asin(vert_back_dist()/bot_length);
function vert_front_h() = front_height * cos(front_angle-90);
function vert_back_dist() = vert_front_h() - back_height * sin(180-back_angle);

function height() = front_height * cos(front_angle-(height_angle()));
function height_angle() = 90-rot_angle();