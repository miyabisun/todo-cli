require! {
  open
  \../modules/todo
}

output = ({id, type, name, url}) ->
  | not id =>
    console.error "Task not found"
  | url => open url
  | _ =>
    console.error "No URL is specified for this task"
    console.error "[#id] #type: #name"

module.exports = (program) ->
  program
    .command \open
    .alias \o
    .argument "[id]", "Task ID"
    .description "Open the following task with URL in your browser"
    .action (id) ->
      if id
        output todo.list!.find (.id is id)
      else
        todo.list!.find -> it.started and not it.done
        |> output
