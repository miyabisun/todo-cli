require! {
  yaml: YAML
  \../modules/todo
}

main = ({json, yaml}) ->
  | json => console.log todo.list!
  | yaml => console.log YAML.stringify todo.list!, null, indent: 2
  | _ =>
    tasks = todo.list!

    # started
    started = tasks.filter -> it.started and not it.done
    if started.length > 0
      console.log "Started tasks:"
      started.for-each ({id, name}) ->
        console.log "  [#id] #name"

    # waiting
    waiting = tasks.filter -> not it.started and not it.done
    if waiting.length > 0
      console.log "Waiting tasks:"
      waiting.for-each ({id, name}) ->
        console.log "  [#id] #name"

    # done
    done = tasks.filter (.done)
    if done.length > 0
      console.log "Done tasks:"
      done.for-each ({id, name}) ->
        console.log "  [#id] #name"

module.exports = (program) ->
  program
    .command \list
    .alias \ls
    .option "-j, --json", "display in JSON format"
    .option "-y, --yaml", "display in YAML format"
    .description "Check the list of ToDo"
    .action main
  program
    .description "Check the list of ToDo"
    .action main
