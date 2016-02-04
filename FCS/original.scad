// Dimensions in m (SI)
tab_height = 0.014;
tab_width  = 0.020;
tab_thick  = 0.006;
tab_space  = 0.053;
tab_round  = 0.002;

// face resolution for curved surfaces
$fn=20;

// first tab
tab();
// second tab
translate([0,tab_space,0]) tab();

module tab()
{
    translate([0,0,-tab_thick/2])
    difference()
    {
        cube(size=[tab_height,
                   tab_width,
                   tab_thick],
             center=false);

        translate([tab_height-tab_round,
                   tab_width -tab_round,
                   0])
        round_cut();

        translate([tab_height-tab_round,
                   tab_round,
                   0])
        rotate([0,0,-90])
        round_cut();
    }
}

module round_cut()
{
    translate([0,0,-tab_thick/2])
    difference()
    {
        cube(size=[tab_round*1.1,
                   tab_round*1.1,
                   tab_thick*2],
             center=false);
        cylinder(h=tab_thick*2,
                 r=tab_round,
                 center=false);
    }
}
