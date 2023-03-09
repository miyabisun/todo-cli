require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "end"
    .alias "e"
    .argument "[id]", "Task ID"
    .description "Finish Task"
    .action (id) ->
      if id
        todo.end id
      else
        task = todo.list!.find -> it.started and not it.done
        todo.end task.id if task
