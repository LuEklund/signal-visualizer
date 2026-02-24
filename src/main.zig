const std = @import("std");
const rl = @import("raylib");

pub fn main() !void {
    // rl.SetConfigFlags(rl.FLAG_WINDOW_RESIZABLE);
    rl.InitWindow(600, 600, "lol");
    defer rl.CloseWindow();

    const scale: f64 = 10.0;
    while (!rl.WindowShouldClose()) {
        rl.ClearBackground(rl.BLACK);
        rl.BeginDrawing();
        rl.BeginMode2D(.{ .zoom = 1 });

        drawGrid(scale);

        for (0..100) |i| {
            const x: f64 = @floatFromInt(i * 2);
            const current = f(x);
            const next = f(x + 1.0);
            rl.DrawLine(
                @intFromFloat(x * scale),
                rl.GetScreenHeight() - @as(c_int, @intFromFloat(current * scale)),
                @intFromFloat((x + 1) * scale),
                rl.GetScreenHeight() - @as(c_int, @intFromFloat(next * scale)),
                rl.GREEN,
            );
        }

        rl.EndMode2D();
        rl.EndDrawing();
    }
}

fn drawGrid(scale: f64) void {
    const color = rl.GRAY;
    for (0..@as(usize, @intCast(@divTrunc(rl.GetScreenHeight(), @as(c_int, @intFromFloat(scale)))))) |i| {
        const y = @as(c_int, @intFromFloat(scale)) * @as(c_int, @intCast(i));
        rl.DrawLine(
            0,
            y,
            rl.GetScreenWidth(),
            y,
            color,
        );
    }
    for (0..@as(usize, @intCast(@divTrunc(rl.GetScreenWidth(), @as(c_int, @intFromFloat(scale)))))) |i| {
        const x = @as(c_int, @intFromFloat(scale)) * @as(c_int, @intCast(i));
        rl.DrawLine(
            x,
            0,
            x,
            rl.GetScreenHeight(),
            color,
        );
    }
}

fn f(x: f64) f64 {
    return @sin(x) + 5;
}
