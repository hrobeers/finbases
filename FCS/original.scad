// Dimensions in m (SI)
tab_height = 0.014;
tab_width  = 0.020;
tab_thick  = 0.006;
tab_space  = 0.053;
tab_round  = 0.002;

// face resolution for curved surfaces
$fn=20;

include <../lib/tab.scad>
// first tab
tab();
// second tab
translate([0,tab_space,0]) tab();
