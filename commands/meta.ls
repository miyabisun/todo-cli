require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "meta"
    .alias "m"
    .argument "<id>", "Task ID"
    .argument "<key>", "Key"
    .argument "[value]", "Value"
    .option "-r, --remove", "Remove key"
    .description "Update meta infomation"
    .action (id, key, value, {remove}) ->
      task = todo.find Number id
      switch
      | not task => return
      | remove =>
        return unless task.meta
        delete task.meta[key]
        todo.update task
      | _ =>
        task.meta = {} unless task.meta
        task.meta[key] = value
        todo.update task
