include <screw.scad>

speaker_size = [40, 28.5];
speaker_margin = 2;
speaker_screw_r = m3_hole_r;
speaker_screw_pos =
[
  [3, 3],
  [3, 25.5],
  [37, 3],
  [37, 25.5],
];

module speaker_hole_blank(thickness)
{
  r = 0.5;
  interval = 2;

  *translate([0, 0.5, 0])
  for (y = [1:13])
  {
    for (x = [4:16])
    {
      translate([x * interval, y * interval, 0])
      cylinder(thickness, r, r);
    }
  }

  translate([0, 0.25, 0])
  {
    screw_blank(speaker_screw_pos, speaker_screw_r, thickness);
    %cube([speaker_size[0], speaker_size[1], thickness]);
  }
}
