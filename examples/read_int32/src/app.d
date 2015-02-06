import std.stdio;
import dinodave;
import std.conv;
import std.bitmanip;

void main(string[] args) {
   enum string IP = "192.168.221.102";
   enum DB = 22;
   enum ADDR = 12;

   string ip = IP;
   if (args.length > 1) {
      ip = args[1];
   }

   try {
      writeln("use ip ", ip);

      auto s7 = new IsoTcp(ip);
      s7.openConnection();
      scope(exit) s7.closeConnection();

      s7.readBytes(DB, ADDR, 8);
      print(12, s7.getS32);
      print(16, s7.getS32);

      s7.readBytes(DB, ADDR, 8);
      print(12, s7.getU32);
      print(16, s7.getU32);
      writeln();
   } catch(Exception e) {
      writeln(e);
   }
}

void print(int addr, int i0) {
   writefln("db12.%s %s", addr, i0);
}
