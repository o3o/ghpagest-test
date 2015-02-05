import unit_threaded.runner;
import std.stdio;

import tests.helper;
import tests.plc;
import dinodave;

int main(string[] args) {
   return runTests!(
         tests.helper
         , tests.plc
         ) (args);
}
