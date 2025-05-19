const std = @import("std");
const ws = @import("websocket");

var connections: std.ArrayList(*Connection) = undefined;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    const allocator = gpa.allocator();
    connections = .init(allocator);

    var ws_conn: ws.Conn = .{
        .compression = null,
    };
    var connection = try Connection.init(null, &ws_conn, null);
    try connection.clientMessage("foo");
}

pub const Connection = struct {
    ws_connection: *ws.Conn,

    pub fn init(_: anytype, conn: *ws.Conn, _: anytype) !@This() {
        std.debug.print("initial client compression: {any}\n", .{conn.compression});

        var connection = @This(){
            .ws_connection = conn,
        };

        try connections.append(&connection);

        return connection;
    }

    pub fn clientMessage(self: *@This(), data: []const u8) !void {
        _ = data;

        // This prints the correct compression: "null".
        std.debug.print("specific client compression: {any}\n", .{self.ws_connection.compression});

        // If you use this `for` loop, it will segfault when trying to read the compression.
        // If you reference the first item directly, it will print an empty compression (which is wrong; it should print "null").

        for (connections.items) |connection| {
            // const connection = connections.items[0];
            std.debug.print("referenced client compression: {any}\n", .{connection.ws_connection.compression});
            try connection.ws_connection.write("Hi all!");
        }
    }
};
