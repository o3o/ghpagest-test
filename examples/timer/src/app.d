import std.stdio;
import std.conv;
import std.bitmanip;

import dinodave;

void main(string[] args) {
   enum string IP = "192.168.0.150";
   enum DB = 100;
   enum ADDR = 20;

   string ip = IP;
   if (args.length > 1) {
      ip = args[1];
   }

   try {
      auto s7 = new IsoTcp(ip);
      s7.openConnection();
      scope(exit) s7.closeConnection();

      ubyte[80] buf;
      enum int BYTES_PER_DINT = 4;

      for (int i = 0; i < 20; ++i) {
         //buf ~= nativeToBigEndian(i * BYTES_PER_DINT + 2);
         put32At(buf, i * BYTES_PER_DINT, i * BYTES_PER_DINT + 2);
      }
      s7.writeBytes(DB, ADDR, 20 * BYTES_PER_DINT, buf);

      s7.readBytes(DB, ADDR, 20 * BYTES_PER_DINT);
      for (size_t i = 0; i < 20; ++i) {
         writefln("addr %03d :%s", i * BYTES_PER_DINT  + 2, s7.getS32());
      }

      s7.writeBytes(DB, 0, 2, [0, 1]);

   } catch(Exception e) {
      writeln(e);
   }
}
