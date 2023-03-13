require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "rename"
    .alias "r"
    .argument "<id>", "Task ID"
    .argument "<name>", "Task Name"
    .description "rename Task"
    .action (id, name) ->
      task = todo.find Number id
      if task
        task.name = name if name
        todo.update task
