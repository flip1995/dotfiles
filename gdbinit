set history file ~/.gdb_history
set history save on
set history size 10000
set debuginfod enabled off

define rerun
    python \
        import re, os; \
        a = gdb.execute("show args", to_string=True); \
        prev_args = re.match('^.*"(.*)".$', a)[1]; \
        os.system("echo -n " + prev_args + " > /tmp/gdb_rerun_args")

    set $i = 0
    while $i < $argc
        shell echo -n " $arg0" >> /tmp/gdb_rerun_args
        set $i = $i + 1
    end

    python \
        import os; \
        args = open("/tmp/gdb_rerun_args").read(); \
        os.remove("/tmp/gdb_rerun_args"); \
        gdb.execute("run " + args)
end
