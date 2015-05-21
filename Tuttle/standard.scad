// Dimensions in m (SI)
top_length   = 0.146;
bot_length   = 0.156;
front_height = 0.05;
back_height  = 0.036;
thick        = 0.015;

front_angle = 95;
back_angle  = 105;

// instantiate
tuttle();

module tuttle()
{
    difference()
    {
        base_shape();
        base_cut();
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
                   back_height,
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


function rot_angle() =
    asin(vert_back_dist()/bot_length);
function vert_front_h() = front_height * cos(front_angle-90);
function vert_back_dist() = vert_front_h() - back_height * sin(180-back_angle);

function height() = front_height * cos(front_angle-(height_angle()));
function height_angle() = 90-rot_angle();