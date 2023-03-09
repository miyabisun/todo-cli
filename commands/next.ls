require! {
  \../modules/todo
}

output = ({id, type, name}) ->
  console.log "[#id] #type: #name"

module.exports = (program) ->
  program
    .command \next
    .alias \n
    .description "Check next task"
    .action ->
      tasks = todo.list!
      switch
      | tasks.find (-> it.started and not it.done) =>
        {id, type, name} = that
        console.log "[#id] #type: #name"
      | tasks.find (-> not it.started and not it.done) =>
        # waiting tasks only
        {id, type, name} = that
        console.log "(waiting) [#id] #type: #name"
      | _ =>
        console.log "all done tasks."
