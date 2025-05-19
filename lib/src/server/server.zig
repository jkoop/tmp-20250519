pub const Conn = struct {
    compression: ?*Conn.Compression = null,

    const Compression = struct {};

    pub fn write(self: *Conn, data: []const u8) !void {
        _ = self;
        _ = data;
    }
};
