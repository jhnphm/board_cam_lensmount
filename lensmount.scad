//diameter
mount_d=13.9;
//radius
mount_r=mount_d/2;
//height
mount_h=15;
mount_thickness=1.25;

mount_hole_spacing=20;
mount_screw_hole_r=0.75;

//side
mount_base_s=17;
//mount_base_s=mount_d+mount_thickness*2;
//height
mount_base_h=8;

$fa=1;
$fs=0.1;


module copy_mirror(vec=[0,1,0]) { 
    children(); 
    mirror(vec) children(); 
} 

module mirror_holes() {
    copy_mirror([1,0,0]) 
    translate([mount_hole_spacing/2,0,0])
        children(); 
}



difference(){
    union(){
        //Top of mount
        cylinder(h=mount_h,r=mount_r+mount_thickness);
        //Mount base
        translate([0,0,mount_base_h/2]) 
            cube([mount_base_s,mount_base_s,mount_base_h],true);
        //Mount lugs
        mirror_holes(){
            hull(){
                cylinder(h=mount_base_h,r=mount_screw_hole_r+mount_thickness);
                mount_hole_lug_d=2*(mount_screw_hole_r+mount_thickness);
                translate([-(mount_hole_spacing-mount_hole_spacing/4),0,mount_base_h/2])
                    cube([mount_hole_spacing/2,mount_hole_lug_d,mount_base_h],true);
            }
        }
        translate([0,-mount_base_s/4,mount_h-(mount_h-mount_base_h)/2])
            cube([mount_screw_hole_r+mount_thickness*2,mount_base_s/2,mount_h-mount_base_h],true);
            //rotate([90,0,0])
            //        cylinder(h=mount_base_s/2,r=(mount_screw_hole_r+mount_thickness));

    }
#
    union(){
        //Mount top
        translate([0,0,-mount_h/2])cylinder(h=mount_h*2,r=mount_r);

        //Mount base
        mount_base_inner_s = mount_base_s-mount_thickness*2;
        mount_base_inner_h = mount_base_h-mount_thickness*2;
        translate([0,0,0]) 
            cube([mount_base_inner_s,mount_base_inner_s,(mount_base_h-mount_thickness)*2],true);

        //Screw holes
        mirror_holes()
        translate([0,0,-mount_base_h/2])
            cylinder(h=mount_base_h*2,r=mount_screw_hole_r);

        translate([0,0,mount_h-((mount_h-mount_base_h)/2)])
        rotate([90,0,0])
                cylinder(h=mount_base_h*2,r=mount_screw_hole_r);
    }
}
