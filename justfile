default: check
alias c := check
alias b := build
alias r := start
alias f := format

check:
    gleam check

build:
    gleam run -m lustre/dev build app

start:
    gleam run -m lustre/dev start

format:
    gleam format src
