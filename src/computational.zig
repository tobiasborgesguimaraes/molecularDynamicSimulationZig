// This file will be reserved for all the functions responsible
// for the computations, mainly the ones present in the SingleStep()
// function in simulation.zig

const math = @import("std").math;
const num = @import("numbers.zig");

pub fn ComputeForces() void {
    var f: f32; var fcVal: f32; var rrCut: f32;
    var rr: f32; var rri: f32; var rri3: f32;
}
