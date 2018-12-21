include <parts/screw.scad>

block_size = 10;

module block(thickness)
{
  difference()
  {
    cube([block_size, block_size, thickness]);
    translate([block_size / 2, block_size / 2, 0])
    cylinder(thickness, m3_hole_r, m3_hole_r);
  }
}

module block_frame(width_intervals, height_intervals, thickness)
{ 
  block(thickness);

  if ((len(width_intervals) == 0) && (len(height_intervals) == 0))
  {
  }
  else if (len(width_intervals) == 0)
  {
    for (i = [0:len(height_intervals) - 1])
    {
      h = sum(take(i, height_intervals)) + (block_size * (i + 1));

      translate([0, h, 0])
      cube([block_size, height_intervals[i], thickness]);

      translate([0, h + height_intervals[i], 0])
      block(thickness);
    }
  }
  else
  {
    for (i = [0:len(width_intervals) - 1])
    {
      w = sum(take(i, width_intervals)) + (block_size * (i + 1));

      translate([w, 0, 0])
      cube([width_intervals[i], block_size, thickness]);

      translate([w + width_intervals[i], 0, 0])
      block(thickness);
    }

    if (len(height_intervals) > 0)
    {
      for (i = [0:len(height_intervals) - 1])
      {
        h = sum(take(i, height_intervals)) + (block_size * (i + 1));

        translate([0, h + height_intervals[i], 0])
        block(thickness);

        translate([0, h, 0])
        cube([block_size, height_intervals[i], thickness]);

        for (j = [0:len(width_intervals) - 1])
        {
          w = sum(take(j, width_intervals)) + (block_size * (j + 1));

          translate([w + width_intervals[j], h, 0])
          cube([block_size, height_intervals[i], thickness]);

          translate([w, h, 0])
          cube([width_intervals[j], height_intervals[i], thickness]);


          translate([w, h + height_intervals[i], 0])
          cube([width_intervals[j], block_size, thickness]);

          translate([w + width_intervals[j], h + height_intervals[i], 0])
          block(thickness);
        }
      }
    }
  }
}

