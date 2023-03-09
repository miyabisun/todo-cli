require! {
  \../modules/todo
}

main = ({json}) ->
  return console.log todo.list! if json
  todo.list!.for-each ({id, name, type}) ->
    console.log "[#id] #type: #name"

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
