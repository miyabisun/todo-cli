require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "pause"
    .alias "p"
    .argument "[id]", "Task ID"
    .description "Pause Task"
    .action (id) ->
      if id
        todo.pause id
      else
        task = todo.list!.find -> it.started and not it.done
        todo.pause task.id if task
