use <round_cut.scad>
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
        round_cut(tab_round, tab_thick);

        translate([tab_height-tab_round,
                   tab_round,
                   0])
        rotate([0,0,-90])
        round_cut(tab_round, tab_thick);
    }
}