import std.stdio;
import std.conv;

import dinodave;

void main(string[] args) {
   enum string IP = "192.168.0.150";
   string ip = IP;
   if (args.length > 1) {
      ip = args[1];
   }
   enum DB = 100;
   enum ADDR = 20;

   writeln("Use ip ", ip);

   auto dc = createConnection(ip);

   writeln("\nTrying to write 4 items");
   ubyte[8] buf;
   enum int TIMERS = 4;
   enum int BYTES_PER_TIMER = 2;

   for (int i = 0; i < TIMERS; ++i) {
      put16At(buf, i * BYTES_PER_TIMER, i * BYTES_PER_TIMER + 2);
   }
   daveWriteBytes(dc, daveDB, DB, ADDR, 4 * BYTES_PER_TIMER, buf.ptr);


   writeln("\nTrying to read 4 items from Timers (supposed to work S7-3xx/4xx)");

   // read 4 timers: each timer has 2 bytes
   const(int) res = daveReadBytes(dc, daveTimer, DB, ADDR, TIMERS * BYTES_PER_TIMER, null);

   writefln("function result:%d=%s\n", res, strerror(res));

   if (res == 0) {
      writeln("Showing the results using daveGetSeconds(dc)");
      writefln("Time: %0.3f, ", daveGetSeconds(dc));
      writefln("%0.3f, ", daveGetSeconds(dc));
      writefln("%0.3f, ", daveGetSeconds(dc));
      writefln("%0.3f\n", daveGetSeconds(dc));

      writeln("Showing the same results using daveGetSecondsAt(dc,position)");
      writefln("Time: %0.3f, ", daveGetSecondsAt(dc, 0));
      writefln("%0.3f, ", daveGetSecondsAt(dc, 2));
      writefln("%0.3f, ", daveGetSecondsAt(dc, 4));
      writefln("%0.3f\n", daveGetSecondsAt(dc, 6));

      writeln("Showing the same results using daveGetSecondsAt(dc,position)");
      writefln("S16: %s, ", daveGetS16At(dc, 0));
      writefln("%s, ", daveGetS16At(dc, 2));
      writefln("%s, ", daveGetS16At(dc, 4));
      writefln("%s", daveGetS16At(dc, 6));
   }
}
