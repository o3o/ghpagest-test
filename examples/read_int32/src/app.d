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

      s7.readBytes(DB, 718, 4);
      print(718, s7.getU16);  
      print(720, s7.getU16);  
      enum INIT = 200;
      enum SIZE = 56;
      for (int i =23,  0; i < 10; ++i) {
         s7.readBytes(23, INIT + i * SIZE, SIZE);
         print(23, INIT + i * SIZE, s7.getU32);
      }
   } catch(Exception e) {
      writeln(e);
   }
}

void print(int addr, int i0) {
   writefln("db12.%s %s", addr, i0);
}

void print(int db, int addr, int i0) {
   writefln("db%s.%s %s", db, addr, i0);
}
