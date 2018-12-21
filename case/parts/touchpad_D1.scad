include <screw.scad>
use <../common/rounded_plate.scad>

module touchpad_D1_blank(thickness)
{
  screw_blank([[7.7, 109.5], [51.7, 109.5], [5.25, 5.1], [50.75, 5.1]], m3_hole_r, thickness);
  translate([0, 10.75, 0])
  rounded_plate([81, 95, thickness], [7, 7, 17, 17]);
  %cube([81, 113.05, thickness]);
}
