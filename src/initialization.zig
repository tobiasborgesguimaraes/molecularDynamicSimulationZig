// This file will be reserved for all the functions responsible
// for initializing the simulation, or the ones present in the
// main() function written in simulation.zig

const num = @import("numbers.zig");

pub fn SetupJob() !void {
    try AllocArrays();
    try InitCoords();
    try InitVels();
    try AccumProps(0);
    num.stepCount = 0;
}
