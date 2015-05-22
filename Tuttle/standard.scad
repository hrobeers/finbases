// Dimensions in m (SI)
top_length   = 0.146;
bot_length   = 0.156;
front_height = 0.05;
back_height  = 0.036;
thick        = 0.015;

front_angle = 95;
back_angle  = 105;

round_radius = 0.0045;

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
}

module base_cut()
{
    // TODO improve
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

    translate([height(),
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

module rounding_cuts()
{
    union()
    {
        translate([round_radius,
                   front_height*1.05,
                   thick-round_radius])
        rotate([90,-90,0])
        round_cut(front_height);

        translate([round_radius,
                   front_height*1.05,
                   round_radius])
        rotate([90,180,0])
        round_cut(front_height);

        translate([round_radius,
                   round_radius/1.1,
                   0])
        rotate([0,0,180])
        round_cut(thick);
    }
}

module round_cut(Height)
{
    difference()
    {
        cube(size=[round_radius*1.1,
                   round_radius*1.1,
                   Height*1.1],
             center=false);
        cylinder(h=Height*1.1,
                 r=round_radius,
                 center=false,
                 $fn=50);
    }
}


function rot_angle() =
    asin(vert_back_dist()/bot_length);
function vert_front_h() = front_height * cos(front_angle-90);
function vert_back_dist() = vert_front_h() - back_height * sin(180-back_angle);

function height() = front_height * cos(front_angle-(height_angle()));
function height_angle() = 90-rot_angle();