const std = @import("std");

const VulkanEngine = @import("VulkanEngine.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer if (gpa.deinit() == .leak) {
        @panic("Leaked memory");
    };

    var cwd_buff: [1024]u8 = undefined;
    const cwd = try std.process.getCwd(&cwd_buff);
    std.log.info("Running from: {s}", .{ cwd });

    var engine = VulkanEngine.init(gpa.allocator());
    defer engine.cleanup();

    engine.run();
}
