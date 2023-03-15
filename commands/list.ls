require! {
  yaml: YAML
  \../modules/todo
}

main = (ids, {start, waiting, end, json, yaml}) ->
  tasks = switch
  | start => todo.list!.filter (.started) .filter (.done) >> (not)
  | waiting => todo.list!.filter (.started) >> (not) .filter (.done) >> (not)
  | end => todo.list!.filter (.done)
  | ids.length > 0 =>
    ids = ids.map Number
    todo.list!.filter (.id in ids)
  | _ => todo.list!
  switch
  | json => console.log tasks
  | yaml => console.log YAML.stringify tasks, null, indent: 2
  | _ =>
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
    .argument "[id...]", "Task ID"
    .option "-s, --start", "Displays tasks that have been started"
    .option "-w, --waiting", "Displays tasks waiting to be executed"
    .option "-e, --end", "Displays completed tasks"
    .option "-j, --json", "display in JSON format"
    .option "-y, --yaml", "display in YAML format"
    .description "Check the list of ToDo"
    .action main
  program
    .description "Check the list of ToDo"
    .action -> main [], {}
