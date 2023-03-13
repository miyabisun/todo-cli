require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "end"
    .alias "e"
    .argument "[id...]", "Task ID"
    .description "Finish Task"
    .action (ids) ->
      if ids.length > 0
        ids.for-each (id) ->
          todo.done Number id
      else
        task = todo.list!.find -> it.started and not it.done
        todo.done task.id if task
