require! {
  fs
  \cdate : {cdate}
  ramda: R
}

path = "#{process.env.HOME}/.todo.json"

list = ->
  try
    fs.read-file-sync path
    |> (.to-string!)
    |> JSON.parse
    |> (or [])
  catch
    fs.write-file-sync path, "[]"

save = (todo) ->
  JSON.stringify todo, null, 2
  |> fs.write-file-sync path, _

find = (id) ->
  list!.find -> id is it.id

find-by = (type, name) ->
  list!.find ->
    type is it.type and name is it.name

update = (task) ->
  unless find task.id
    console.error "not found task:", task
    return
  (todo = list!)
  |> R.find-index (.id is task.id)
  |> R.lens-index
  |> R.set _, {...task, updated: cdate!.text!}, todo
  |> save

new-id = (todo) ->
  todo.map (.id) .reduce _, 1
  <| (max, it) -> Math.max max, it + 1

add = ({name, type, url}) ->
  now = cdate!.text!
  if task = find-by type, name
    return update {...task, started: no, done: no}
  todo = list!
  save [...todo, {
    id: new-id todo
    name, type, url
    started: no
    done: no
    created: now
    updated: now
  }]

remove = (id) ->
  list!.filter (.id isnt id)
  |> save

remove-all-done = ->
  list!.filter (.done) >> (not)
  |> save

remove-by = (type, name) ->
  unless task = find-by type, name
    console.error "not found task:", {type, name}
    return
  remove task.id

start = (id) ->
  if task = list!.find (.id is id)
    update {...task, started: yes, done: no}

done = (id) ->
  if task = list!.find (.id is id)
    update {...task, started: yes, done: yes}

pause = (id) ->
  if task = list!.find (.id is id)
    update {...task, started: no, done: no}

reindex = ->
  list!.map (task, i) -> {...task, id: i + 1}
  |> save

module.exports = {
  list, find, find-by, add, update, remove, remove-by
  start, done, pause, remove-all-done, reindex, save
}
