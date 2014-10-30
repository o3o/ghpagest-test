module dinodave.helper;
import std.exception;
import dinodave.nodave;

void put8(ubyte[] buffer, in int value) {
   davePut8(buffer.ptr, value);
}

void put16(ubyte[] buffer, in int value) {
   davePut16(buffer.ptr, value);
}

void put32(ubyte[] buffer, in int value) {
   davePut32(buffer.ptr, value);
}

void putFloat(ubyte[] buffer, in float value) {
   davePutFloat(buffer.ptr, value);
}

void put8At(ubyte[] buffer, in int pos, in int value) {
   enforce(pos < buffer.length && pos >= 0);
   davePut8At(buffer.ptr, pos, value);
}

void put16At(ubyte[] buffer, int pos, in int value) {
   enforce(pos < (buffer.length - 1) && pos >= 0);
   davePut16At(buffer.ptr, pos, value);
}

void put32At(ubyte[] buffer, in int pos, in int value) {
   enforce(pos < (buffer.length - 3) && pos >= 0);
   davePut32At(buffer.ptr, pos, value);
}

void putFloatAt(ubyte[] buffer, in int pos, in float value) {
   enforce(pos < (buffer.length - 3) && pos >= 0);
   davePutFloatAt(buffer.ptr, pos, value);
}
ubyte toBCD(ubyte i) {
   return daveToBCD(i);
}

ubyte fromBCD(ubyte i) {
   return daveFromBCD(i);
}
