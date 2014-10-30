module tests.helper;

import std.stdio;
import unit_threaded;

import dinodave;

@UnitTest
void put8_should_set_byte() {
   ubyte[] a = [1, 2, 3, 4];
   a.put8(50);
   a.shouldEqual([50, 2, 3, 4]);
   a.put8(51);
   a.shouldEqual([51, 2, 3, 4]);
}

@UnitTest
void put8at_should_set_byte_at_position() {
   ubyte[] a = [1, 2, 3, 4];
   a.put8At(0, 50);
   a.shouldEqual([50, 2, 3, 4]);
   a.put8At(1, 51);
   a.shouldEqual([50, 51, 3, 4]);

   a.put8At(19, 52).shouldThrow!Exception;
   a.put8At(-19, 52).shouldThrow!Exception;

      //ubyte* p = davePut8(a.ptr, 50);
      //ubyte[] b = (p)[0..2];
      //writeln(a);
      //writeln(b);
}
@UnitTest
void daveput8at_should_set_byte_at_position() {
   ubyte[] a = [1, 2, 3, 4];
   davePut8At(a.ptr, 0, 50);
   a.shouldEqual([50, 2, 3, 4]);
   davePut8At(a.ptr, 1, 51);
   a.shouldEqual([50, 51, 3, 4]);

   // Segmentation fault!!!!
   //davePut8At(a.ptr, 19, 52).shouldNotThrow!Exception;
   // davePut8At(a.ptr, -19, 52).shouldNotThrow!Exception;
}

void testBcdToDec() {
   (0x0).toBCD().shouldEqual(0);
   (0x5).toBCD().shouldEqual(5);
   (0xA).toBCD().shouldEqual(16);
   (11).toBCD().shouldEqual(17);
} 
