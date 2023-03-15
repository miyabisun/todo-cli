require! {
  yaml: YAML
  \../modules/todo
}

output = ({json, yaml, task}) ->
  | json => console.log task
  | yaml => console.log YAML.stringify task, null, indent: 2
  | _ =>
    {id, name} = task
    console.log "[#id] #name"

module.exports = (program) ->
  program
    .command \next
    .alias \n
    .description "Check next task"
    .option "-j, --json", "display in JSON format"
    .option "-y, --yaml", "display in YAML format"
    .action (settings) ->
      tasks = todo.list!
      switch
      | tasks.find (-> it.started and not it.done) =>
        output {...settings, task: that}
      | tasks.find (-> not it.started and not it.done) =>
        output {...settings, task: that}
      | _ =>
        console.log "all done tasks."
