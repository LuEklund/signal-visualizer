const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib_dep = b.dependency("raylib", .{ .target = target, .optimize = optimize });
    const raylib = b.addTranslateC(.{
        .root_source_file = raylib_dep.path("src/raylib.h"),
        .optimize = optimize,
        .target = target,
    }).createModule();
    raylib.addIncludePath(raylib_dep.path("src/"));

    const exe = b.addExecutable(.{
        .name = "signal_visualizer",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "raylib", .module = raylib },
            },
        }),
    });
    exe.root_module.linkLibrary(raylib_dep.artifact("raylib"));
    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| run_cmd.addArgs(args);
}
