m2_hole_r = 1.1;
m3_hole_r = 1.6;
m11_hole_r = 5.6;
m12_hole_r = 6.1;
m16_hole_r = 8.1;

m3_nut_hole_r = 2.75;

module screw_blank(points, hole_r, thickness)
{
  for (p = points)
  {
    translate([p[0], p[1], 0])
    cylinder(thickness, hole_r, hole_r);
  }
}

module nut_blank(points, nut_hole_r, angle, thickness)
{
  hex=
  [
    [nut_hole_r, nut_hole_r * tan(30)],
    [0, nut_hole_r * (2 / sqrt(3))],
    [-nut_hole_r, nut_hole_r * tan(30)],
    [-nut_hole_r, -nut_hole_r * tan(30)],
    [0, -nut_hole_r * (2 / sqrt(3))], 
    [nut_hole_r, -nut_hole_r * tan(30)]
  ];

  for (p = points)
  {
    linear_extrude(height=thickness)
    translate([p[0], p[1], 0])
    rotate(angle)
    polygon(hex);
  }
}

