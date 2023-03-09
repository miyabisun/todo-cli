require! {
  \../modules/todo
}

module.exports = (program) ->
  program
    .command "reindex"
    .description "ID reassignment",
    .action -> todo.reindex!
