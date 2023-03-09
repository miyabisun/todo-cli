require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "remove"
    .alias "r"
    .argument "[id]", "Task ID"
    .description "Delete a task from ToDo"
    .option "-d, --done", "Delete all completed tasks"
    .action (id, {done}) ->
      switch
      | done => todo.remove-all-done!
      | id => todo.remove Number id
