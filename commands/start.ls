require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "start"
    .alias "s"
    .argument "[id]", "Task ID"
    .description "Start Task"
    .action (id) ->
      if id
        todo.start Number id
      else
        todo.start todo.list!.0.id
