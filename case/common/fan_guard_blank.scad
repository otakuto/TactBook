//FIXME
module fan_guard_blank(thickness, count, r, frame_thickness, blank_thickness)
{
  module ring(outer_r, inner_r, thickness)
  {
    difference()
    {
      cylinder(thickness, outer_r, outer_r);
      cylinder(thickness, inner_r, inner_r);
    }
  }

  difference()
  {
    union()
    {
      for (i = [0:count])
      {
        ring(r - (i * (frame_thickness + blank_thickness)) - blank_thickness + frame_thickness, r - ((i + 1) * (frame_thickness + blank_thickness)) + frame_thickness, thickness);
      }
    }

    for (i = [0:7])
    {
      rotate(45 * i)
      translate([0, 12, 0])
      cube([r, frame_thickness, t]);
    }
  }
}

