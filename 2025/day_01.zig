const std = @import("std");

pub fn part1(input: []const u8) !usize {
    var dial_pos: isize = 50;
    var num_of_zeros: usize = 0;

    var iter = std.mem.tokenizeScalar(u8, input, '\n');

    while (iter.next()) |token| {
        const direction: []const u8 = token[0..0];
        const clicks = switch (token[0]) {
            'R' => try std.fmt.parseInt(isize, token[1..], 10),
            'L' => -try std.fmt.parseInt(isize, token[1..], 10),
            else => return error.InvalidCharacter,
        };
        if (std.mem.eql(u8, direction, "R")) {
            dial_pos = @mod((dial_pos + clicks), 100);
            if (dial_pos == 0) num_of_zeros += 1;
        } else {
            dial_pos = @mod((dial_pos - clicks), 100);
            if (dial_pos == 0) num_of_zeros += 1;
        }
    }

    return num_of_zeros;
}

pub fn part2(input: []const u8) !usize {
    var dial_pos: isize = 50;
    var counter: usize = 0;
    var iter = std.mem.tokenizeScalar(u8, input, '\n');
    while (iter.next()) |line| {
        const clicks = switch (line[0]) {
            'R' => try std.fmt.parseInt(isize, line[1..], 10),
            'L' => -try std.fmt.parseInt(isize, line[1..], 10),
            else => return error.InvalidCharacter,
        };

        counter += @abs(@divFloor(dial_pos + clicks, 100));
        if (dial_pos == 0 and clicks < 0) counter -= 1;
        dial_pos = @mod(dial_pos + clicks, 100);
        if (dial_pos == 0 and clicks <= 0) counter += 1;
    }

    return counter;
}
