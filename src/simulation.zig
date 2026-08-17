const std = @import("std");
const init = @import("initialization.zig");
const num = @import("numbers.zig");

pub fn SingleStep() !void {
    num.stepCount += 1;
    var timeNow = num.stepCount * deltaT;
    
    ComputeForces(); // Only use try when the function can return an error
    try LeapFrogStep();
    try ApplyBoundaryConditions();
    try EvalProps();
    try AccumProps(1);

    if (num.stepCount % stepAvg == 0) {
        try AccumProps(2);
        try PrintSummary(stdout);
        try AccumProps(0);
    }
}

pub fn main() !void {
    var gpa_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa_allocator.deinit();
    const allocator = gpa_allocator.allocator();

    var args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    try init.GetNameList(argc, argv);
    try init.PrintNameList(stdout);
    try init.SetParams();
    try init.SetupJob();

    var moreCycles = true;
    while (moreCycles) {
        try SingleStep();
        if (num.stepCount >= stepLimit) {
            moreCycles = false;
        }
    }
}


