require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "remove"
    .alias "rm"
    .arguments "[id...]", "Task ID"
    .description "Delete a task from ToDo"
    .option "-d, --done", "Delete all completed tasks"
    .action (ids, {done}) ->
      | done => todo.remove-all-done!
      | ids.length > 0 =>
        ids.for-each (id) ->
          todo.remove Number id
