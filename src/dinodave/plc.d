module dinodave.plc;

import std.conv;
import std.socket;
import std.string;
import std.stdio;

import dinodave.nodave;

interface IPlc {
   void openConnection();
   void closeConnection();
   void readBytes(in int DB, in int start, in int length);
   int getS8();
   int getU8();
   int getS16();
   int getU16();
   int getS32();
   int getU32();
   float getFloat();

   int getS8At(int position);
   int getU8At(int position);
   int getS16At(int position);
   int getU16At(int position);
   int getS32At(int position);
   int getU32At(int position);
   float getFloatAt(int position);

   void setBit(in int DB, in int byteAddress, in int bitAddress);
   void clearBit(in int DB, in int byteAddress, in int bitAddress);

   void writeBytes(int DB, int start, int length, ubyte[] buffer);
   int readPLCTime();
}

class IsoTcp: IPlc {
   private immutable(string) ip;
   private immutable(int) port;
   this(in string ipAddress, in int port = 102) {
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
            daveSetTimeout(di, 5_000_000);
            enum int MPI = 0;
            enum int RACK = 0;
            enum int SLOT = 2;
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

   /**
     Reads a sequence of bytes from PLC memory.

     Params:  
        DB = The number of a data block
        start = The address of the first byte in the block.
        length = The number of bytes to read.
    */
   void readBytes(in int DB, in int start, in int length) {
      int err = daveReadBytes(dc, daveDB, DB, start, length, null);
      if (err != 0) {
         string strErr = to!string(daveStrerror(err));
         throw new NodaveException(strErr);
      }
   }

   int getS8() { return daveGetS8(dc); }
   int getU8() { return daveGetU8(dc); }
   int getU16() { return daveGetU16(dc); }
   int getU32() { return daveGetU32(dc); }

   int getS16() { return daveGetS16(dc); }
   int getS32() { return daveGetS32(dc); }
   float getFloat() { return daveGetFloat(dc); }

   int getS8At(int position) { return daveGetS8At(dc, position); }
   int getU8At(int position) { return daveGetU8At(dc, position); }
   int getS16At(int position) { return daveGetS16At(dc, position); }
   int getU16At(int position) { return daveGetU16At(dc, position); }
   int getS32At(int position) { return daveGetS32At(dc, position); }
   int getU32At(int position) { return daveGetU32At(dc, position); }
   float getFloatAt(int position) { return daveGetFloatAt(dc, position); }

   void setBit(in int DB, in int byteAddress, in int bitAddress) {
      int res = daveSetBit(dc, daveDB, DB, byteAddress, bitAddress);
      if (res != 0) {
         throw new NodaveException("Error no " ~ to!string(res));
      }
   }

   void clearBit(in int DB, in int byteAddress, in int bitAddress) {
      int res = daveClrBit(dc, daveDB, DB, byteAddress, bitAddress);
      if (res != 0) {
         throw new NodaveException("Error no " ~ to!string(res));
      }
   }

   /**
     Write a sequence of bytes from a buffer to PLC memory.
     Params:  
        DB = The number of a data block
        start = The address of the first byte in the block.
        length = The number of bytes to write.
        buffer = Buffer to write.
    */
   void writeBytes(int DB, int start, int length, ubyte[] buffer) {
      int res = daveWriteBytes(dc, daveDB, DB, start, length, buffer.ptr);
      if (res != 0) {
         throw new NodaveException("Error no " ~ to!string(res));
      }
   }

   int readPLCTime() {
      return daveReadPLCTime(dc);
   }
   
}

class NodaveException: Exception {
   this(string message, string file = __FILE__, size_t line = __LINE__, Throwable next = null) {
      super(message, file, line, next);
   }
}
