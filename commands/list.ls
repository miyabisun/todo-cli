require! {
  \../modules/todo
}

main = ({json}) ->
  return console.log todo.list! if json
  tasks = todo.list!

  # started
  started = tasks.filter -> it.started and not it.done
  if started.length > 0
    console.log "Started tasks:"
    started.for-each ({id, type, name}) ->
      console.log "  [#id] #type: #name"

  # waiting
  waiting = tasks.filter -> not it.started and not it.done
  if waiting.length > 0
    console.log "Waiting tasks:"
    waiting.for-each ({id, type, name}) ->
      console.log "  [#id] #type: #name"

  # done
  done = tasks.filter (.done)
  if done.length > 0
    console.log "Done tasks:"
    done.for-each ({id, type, name}) ->
      console.log "  [#id] #type: #name"

module.exports = (program) ->
  program
    .command \list
    .alias \ls
    .description "Check the list of ToDo"
    .action main.bind null, {json: yes}
  program
    .option "-j, --json", "display in JSON format"
    .description "Check the list of ToDo"
    .action main
