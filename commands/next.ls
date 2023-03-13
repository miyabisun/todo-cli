require! {
  \../modules/todo
}

output = ({id, name}) ->
  console.log "[#id] #name"

module.exports = (program) ->
  program
    .command \next
    .alias \n
    .description "Check next task"
    .action ->
      tasks = todo.list!
      switch
      | tasks.find (-> it.started and not it.done) =>
        {id, name} = that
        console.log "[#id] #name"
      | tasks.find (-> not it.started and not it.done) =>
        # waiting tasks only
        {id, name} = that
        console.log "(waiting) [#id] #name"
      | _ =>
        console.log "all done tasks."
