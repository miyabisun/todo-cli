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
      tasks = todo.list!.filter (.done is no)
      if task = tasks.find (.started is yes)
        return output task
      output tasks.0
