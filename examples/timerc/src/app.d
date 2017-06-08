import std.stdio;
import std.conv;

import dinodave;

void main(string[] args) {
   enum string IP = "192.168.0.150";
   string ip = IP;
   if (args.length > 1) {
      ip = args[1];
   }

   writeln("Use ip ", ip);
   writeln("\nTrying to read 4 items from Timers (supposed to work S7-3xx/4xx)\n");
   auto dc = createConnection(ip);
   // read 4 timers: each timer has 2 bytes
   const(int) res = daveReadBytes(dc, daveTimer, 0, 0, 4, null);

   writefln("function result:%d=%s\n", res, daveStrerror(res));

   if (res == 0) {
      writeln("\nShowing the results using daveGetSeconds(dc)\n");
      writefln("Time: %0.3f, ", daveGetSeconds(dc));
      writefln("%0.3f, ", daveGetSeconds(dc));
      writefln("%0.3f, ", daveGetSeconds(dc));
      writefln(" %0.3f\n", daveGetSeconds(dc));

      writeln("\nShowing the same results using daveGetSecondsAt(dc,position)\n");
      writefln("Time: %0.3f, ", daveGetSecondsAt(dc, 0));
      writefln("%0.3f, ", daveGetSecondsAt(dc, 2));
      writefln("%0.3f, ", daveGetSecondsAt(dc, 4));
      writefln(" %0.3f\n", daveGetSecondsAt(dc, 6));
   }
}
