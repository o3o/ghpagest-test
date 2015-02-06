import std.stdio;
import dinodave;
import std.conv;
import std.bitmanip;
import std.datetime;
void main(string[] args) {
   enum string IP = "192.168.221.102";
   enum DB = 23;
   enum ADDR = 82;

   string ip = IP;
   if (args.length > 1) {
      ip = args[1];
   }

   try {
      writeln("use ip ", ip);

      auto s7 = new IsoTcp(ip);
      s7.openConnection();
      scope(exit) s7.closeConnection();
      writeln("read time: ");
      s7.readPLCTime();
      for (size_t i = 0; i < 10; ++i) {
         writeln(s7.getU8().fromBCD());
      }
      DateTime dt = s7.getPLCTime();
      writeln(dt.toSimpleString);

      //writeln("set sys time: ");
      //s7.setPLCTimeToSystime();

      //dt = s7.getPLCTime();
      //writeln(dt.toSimpleString);


   } catch(Exception e) {
      writeln(e);
   }
}
