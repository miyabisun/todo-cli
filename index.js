#!/usr/bin/env node

require("livescript");
const {program} = require("commander");
const commands = require("./commands/index");

commands(program);
program.parse(process.argv);
