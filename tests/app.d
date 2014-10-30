import unit_threaded.runner;
import std.stdio;

import tests.helper;
import dinodave;

int main(string[] args) {
   return runTests!(
         tests.helper
         ) (args);
}
