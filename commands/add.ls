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
    .action (name, {url}) ->
      todo.add name, {url}
