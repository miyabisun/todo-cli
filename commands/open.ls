require! {
  open
  \../modules/todo
}

output = ({id, type, name, url}) ->>
  if url
    open url
  else
    console.error "No URL is specified for this task"
    console.error "[#id] #type: #name"

module.exports = (program) ->
  program
    .command \open
    .alias \o
    .description "Open the following task with URL in your browser"
    .action ->>
      tasks = todo.list!.filter (.done is no)
      if task = tasks.find (.started is yes)
        return output task
      output tasks.0
