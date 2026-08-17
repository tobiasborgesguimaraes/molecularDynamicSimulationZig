const std = @import("std");
const init = @import("initialization.zig");
const num = @import("numbers.zig");

pub fn SingleStep() !void {
    num.stepCount += 1;
    var timeNow = num.stepCount * deltaT;
    
    try ComputeForces();
    try LeapFrogStep();
    try ApplyBoundaryConditions();
    try EvalProps();
    try AccumProps(1);

    if (num.setpCount % stepAvg == 0) {
        try AccumProps(2);
        try PrintSummary(stdout);
        try AccumProps(0);
    }
}

pub fn main(process_init: std.process.Init) !void {
    var args = try process_init.minimal.args.iterateAllocator(init.gpa);
    defer args.deinit();

    try init.GetNameList(argc, argv);
    try init.PrintNameList(stdout);
    try init.SetParams();
    try init.SetupJob();

    var moreCycles = 1;
    while (moreCycles) {
        SingleStep();
        if (num.stepCount >= stepLimit) {
            moreCycles = 0;
        }
    }
}


