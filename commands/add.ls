require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "add"
    .alias "a"
    .argument "<name>", "Task Name"
    .description "Finish Task",
    .option "-u, --url <value>", "Refernce Site"
    .option "-s, --start", "Add started task"
    .option "-e, --end", "Add done task"
    .action (name, {url, start, end}) ->
      | end =>
        todo.add name, {url}, {started: yes, done: yes}
      | start =>
        todo.add name, {url}, {started: yes, done: false}
      | _ =>
        todo.add name, {url}
