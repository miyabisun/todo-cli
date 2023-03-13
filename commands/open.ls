require! {
  open
  \../modules/todo
}

output = ({id, name, meta}) ->
  | not id =>
    console.error "Task not found"
  | meta?.url => open meta.url
  | _ =>
    console.error "No URL is specified for this task"
    console.error "[#id] #name"

module.exports = (program) ->
  program
    .command \open
    .alias \o
    .argument "[id]", "Task ID"
    .description "Open the following task with URL in your browser"
    .action (id) ->
      if id
        todo.list!.find (.id is Number id)
        |> (or {})
        |> output
      else
        todo.list!.find -> it.started and not it.done
        |> (or {})
        |> output
