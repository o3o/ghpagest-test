# dinodave
[![Build Status](https://travis-ci.org/o3o/dinodave.svg?branch=master)](https://travis-ci.org/o3o/dinodave)
[![Dub version](https://img.shields.io/dub/v/dinodave.svg)](https://code.dlang.org/packages/dinodave)
[![Dub download Status](https://img.shields.io/dub/dt/dinodave.svg)](https://code.dlang.org/packages/dinodave)

A simple D binding to [LIBNODAVE, a free library to communicate to Siemens S7 PLCs](https://github.com/netdata/libnodave)

## Compiling
With dub:

```sh
$ dub build
```
with make (_linux_):
```sh
$ make
```
(_win32_)
```sh
$ make -f makefile.win32
```

On Win32 see also [wiki](https://github.com/o3o/dinodave/wiki/Compiling%20for%20Win32).

## Testing
With dub:

```sh
$ dub test
```

with make (only for linux):

```sh
$ make test
```

## Example usage
```D
import std.stdio;
import dinodave;

void main(string[] args) {
   enum string IP = "192.168.221.102";
   enum DB = 11;
   try {
      auto s7 = new IsoTcp(IP);
      s7.openConnection();
      scope(exit) s7.closeConnection();

      int start = 160;
      int length = 2;
      s7.readBytes(DB, start, length);

      int a = s7.getU16();
      writeln("db11.160: ", a);

   } catch(Exception e) {
      writeln(e);
   }
}
```

See also directory `examples/` and [wiki](https://github.com/o3o/dinodave/wiki/).

## Compiling and running code examples

The code examples in `examples` directory are simple applications that perform simple PLC operations

For some examples (`float` and `read_write`) dub includes subpackage, so to compile:

```
$ make s=float
```
or
```
$ dub build dinodave:float
````

for the other examples:
```
$ cd examples/x
$ make
```

## Documentation
The documentation is generated automatically (ddox) and is accessible by reference [documentation API](https://o3o.github.io/ghpagest-test/)


## Install libnodave

```
$ git clone git@github.com:netdata/libnodave.git
$ cd libnodave
$ make
$ sudo make install
```

or use `install-libnodave.sh`
