mysh - A very simple shell
==========================

This is a very simple shell built for NCTU Advanced Unix Programming course.

# What are supported

- Built-in commands
    - `cd`: change current working directory
    - `exit`: terminate the shell
    - `export`: set environment variable
    - `unset`: unset environment variable
    - `jobs`: list all current jobs
    - `fg`: put a job to foreground
    - `bg`: put a job to background
    - `kill`: kill a job
- Run any Unix programs either in foreground or background (`&`)
- `Ctrl-C` and `Ctrl-Z` signal handling
- Standard input/output redirection operators: `<` and `>`
- Create pipeline using pipe operator: `|`
- Filename expansion with `*` and `?` operators
- Job control support: `Ctrl-Z`, `jobs`, `fg`, and `bg`

**[Important]** Our parser does not recognize quotation marks as special characters; therefore, the command `echo "124 456"` will have output `"123 456"`, but not treat `"123 456"` as a single argument and show `123 456`.

## Environment Variables

### Usage

```bash
mysh> export KEY=value
mysh> unset KEY
```

### Example

```bash
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> export TEST=mysh
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> printenv TEST
mysh
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> unset TEST
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh>
```

## Filename Expansion

### Usage

We accept the basic regular expression syntax: `*` and `?` to expand pathnames matching the pattern.

### Example

```bash
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> ls *
Makefile    mysh        mysh.c      mysh.o
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> ls mysh*
mysh    mysh.c  mysh.o
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> ls *.c
mysh.c
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> ls m?sh.?
mysh.c  mysh.o
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh>
```

## Job Control

**[Important]** The maximum number of background jobs is limited to **20** by default. (defined as `NR_JOBS` macro)

### Usage

```bash
mysh> jobs   # list all jobs
mysh> fg %<job_id>
mysh> fg <pid>
mysh> bg %<job_id>
mysh> bg <pid>
mysh> kill %<job_id>
mysh> kill <pid>
```

### Example

```bash
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> sleep 30 &
[1] 2443
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> sleep 60 &
[2] 2444
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> jobs
[1] 2443    running sleep 30
[2] 2444    running sleep 60
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> fg %1
[1] 2443    continued   sleep 30
^Z[1]   2443    suspended   sleep 30   # Press Ctrl-Z
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> bg %1
[1] 2443    continued   sleep 30   # Continue to run Job 1 in background
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> jobs
[1] 2443    continued   sleep 30
[2] 2444    running sleep 60
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh> kill %2
[2] 2444    terminated  sleep 60
hungys in /Users/hungys/Workspace/UnixCourse/HW/hw3
mysh>
[1] 2443    done    sleep 30   # Job 1 is finished in background
```

Notice that for the last case, "done" message will not show up until you execute command next time. The zombie processes will also be reaped at the same time.

# Build and Run

*mysh* is implemented in pure C, and we have provided a simple `Makefile`.

To compile the source code, simply type `make`. Then you can execute `./mysh` to launch the shell.

![Screenshot](http://i.imgur.com/elvmddH.png)
