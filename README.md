# tmp-20250519

This project demonstrates a bug in the Zig compiler (as of 2025-05-19, 74a3ae492).

**Expected output**

```plain
initial client compression: null
specific client compression: null
referenced client compression: null
[...]
```

**Actual output** [full output](./log.txt)

```plain
initial client compression: null
specific client compression: null
Segmentation fault at address 0x3
/home/joek/git/jkoop/tmp-20250519/main/src/main.zig:44:97: 0x10e180f in clientMessage (main)
            std.debug.print("referenced client compression: {any}\n", .{connection.ws_connection.compression});
                                                                                                ^
[...]
```

**Reproduction steps**

1. clone this repo
2. `cd` into its `main` directory
3. run
   ```sh
   zig build run
   ```
