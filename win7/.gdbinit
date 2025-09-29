# Win 7 32 bits requires weird adjustments, like a debugger not showing
# std::string beyond it's memory adresses.

# - Code::Blocks 17 works, but shipped old gdb cannot use python pretty printers THAT COME WITH IT.
# - Newer gdb understands python pretty printers, but doesn't ship them

# Solution: Use .gdbinit to tell the modern gdb where are Code::Blocks' pretty printers.

python

import sys
import os
import glob

# Change this path to wherever your GCC’s libstdc++ python printers live
base = r"C:\Program Files\CodeBlocks\MinGW\share"
matches = glob.glob(os.path.join(base, "gcc-*", "python"))
if matches:
    sys.path.insert(0, matches[0])

    from libstdcxx.v6 import printers
    printers.register_libstdcxx_printers(gdb.current_objfile())


end
