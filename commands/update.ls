require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "update"
    .alias "u"
    .argument "<id>", "Task ID"
    .description "Update Task"
    .option "-n, --name <value>", "Task Name"
    .option "-t, --type <value>", "Category"
    .option "-u, --url <value>", "Refernce Site"
    .action (id, {name, type, url}) ->
      task = todo.find Number id
      if task
        task.name = name if name
        task.type = type if type
        task.url = url if url
        todo.update task
