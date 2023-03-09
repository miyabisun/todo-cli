require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "add"
    .alias "a"
    .argument "<name>", "Task Name"
    .description "Finish Task",
    .option "-t, --type <value>", "Category"
    .option "-u, --url <value>", "Refernce Site"
    .action (name, {type, url}) ->
      todo.add {name, type, url}
