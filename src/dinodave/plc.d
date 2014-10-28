module dinodave.plc;

import std.conv;
import std.socket;
import std.string;
import std.stdio;

import dinodave.nodave;

interface IPlc {
   void openConnection();
   void closeConnection();
   void readBytes(int datablockNumber, int start, int length);
   int getU8At(int position);
   int getU16();
   int getU32();
   int get8At(int position);
   int get16();
   int get32();
   void writeBytes(int datablockNumber, int start, int length, ubyte[] buffer);
}

class IsoTcp: IPlc {
   private string ip;
   private int port;
   this(string ipAddress, int port = 102) {
      assert(ipAddress.length > 0);
      ip = ipAddress;

      assert(port > 0);
      this.port = port;
   }

   private daveConnection* dc;
   private _daveOSserialType fds;
   void openConnection() {
      try {
         auto sock = new TcpSocket(new InternetAddress(ip, to!(ushort)(port)));

         fds.rfd = sock.handle;
         fds.wfd = fds.rfd;

         if (fds.rfd > 0) { 
            daveInterface* di = daveNewInterface(fds, "IF1", 0, daveProtoISOTCP, daveSpeed9k);
            daveSetTimeout(di, 5000000);
            enum int MPI = 0;
            enum RACK = 0;
            enum SLOT = 2;
            dc = daveNewConnection(di, MPI, RACK, SLOT);
            if (daveConnectPLC(dc) != 0) {
               throw new NodaveException("Couldn't connect to PLC with ip " ~ ip);
            }
         } else {
            throw new NodaveException("Couldn't open TCP port. Please make sure a CP is connected and the IP address is ok.");
         }

      } catch(Exception e) {
         throw new NodaveException("Generic exception");
      }
   }

   void closeConnection() {
      //todo verificare se e' aperta
      //closeSocket(fds.rfd);
   }

   void readBytes(int datablockNumber, int start, int length) {
      int err = daveReadBytes(dc, daveDB, datablockNumber, start, length, null);
      if (err != 0) {
         string strErr = to!string(daveStrerror(err));
         throw new NodaveException(strErr);
      }
   }

   int getU8At(int position) { return daveGetU8At(dc, position); }
   int getU16() { return daveGetU16(dc); }
   int getU32() { return daveGetU32(dc); }

   int get8At(int position) { return daveGetS8At(dc, position); }
   int get16() { return daveGetS16(dc); }
   int get32() { return daveGetS32(dc); }

   void writeBytes(int datablockNumber, int start, int length, ubyte[] buffer) {
      int res = daveWriteBytes(dc, daveDB, datablockNumber, start, length, buffer.ptr);
      if (res != 0) {
         throw new NodaveException("Error no " ~ to!string(res));
      }
   }
}

class NodaveException: Exception {
   this(string message, string file = __FILE__, size_t line = __LINE__, Throwable next = null) {
      super(message, file, line, next);
   }
}
