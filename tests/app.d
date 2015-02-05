import unit_threaded.runner;
import std.stdio;

int main(string[] args) {
   return args.runTests!(
         "dinodave.helper",
         "tests.helper"
         );
}
