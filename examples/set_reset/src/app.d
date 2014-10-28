import std.stdio;
import dinodave;

enum DB = 22;
void main(string[] args) {
   enum string IP = "192.168.221.102";

   try {
      auto s7 = new IsoTcp(IP);
      s7.openConnection();

      scope(exit) s7.closeConnection();
      read(s7);

      writeln("trigger...");
      ubyte[] buffer = [0x0, 0x01];
      s7.writeBytes(DB, 4, 2, buffer);
      read(s7);

      //writeln("reset");
      //s7.writeBytes(DB, 4, 2, [0, 0]);
      //read(s7);

      readTare(s7);
      readNet(s7);

   } catch(Exception e) {
      writeln(e);
   }
}

enum CAPS = 10;
private void readTare(IPlc s7) {
   s7.readBytes(DB, 20, 4 * CAPS);
   writeln("Tare");
   writeln("========");
      
   for (size_t i = 0; i < CAPS; ++i) {
      writefln("cap %s: %s mg", i, s7.get32);
   }
}
private void readNet(IPlc s7) {
   s7.readBytes(DB, 60, 4 * CAPS);
   writeln("Net");
   writeln("========");
      
   for (size_t i = 0; i < CAPS; ++i) {
      writefln("cap %s: %s mg", i, s7.get32);
   }
}


private void read(IPlc s7) {
   s7.readBytes(DB, 0, 6);
   writeln("mode db22.0: ", s7.get16);
   writeln("number db22.2: ", s7.get16);
   writeln("trigger db22.4: ", s7.get16);
   writeln();
}
