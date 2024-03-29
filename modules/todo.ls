require! {
  fs
  \cdate : {cdate}
  ramda: R
}
path = "#{process.env.HOME}/.todo.json"

list = ->
  if fs.exists-sync path
    fs.read-file-sync path
    |> (.to-string!)
    |> JSON.parse
  else
    fs.write-file-sync path, "[]"
    return []

save = (todo) ->
  JSON.stringify todo, null, 2
  |> fs.write-file-sync path, _
  return todo

find = (id) ->
  list!.find (.id is id)

find-by = (name) ->
  list!.find (.name is name)

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

add = (name, meta, update = {}) ->
  now = cdate!.text!
  return that if find-by name
  todo = list!
  task = {name, meta}
    <<< do
      id: new-id todo
      started: no
      done: no
      created: now
      updated: now
    <<< {...update}
  save [...todo, task]

remove = (id) ->
  list!.filter (.id isnt id)
  |> save

remove-all-done = ->
  list!.filter (.done) >> (not)
  |> save

remove-by = (name) ->
  unless task = find-by name
    console.error "not found task:", name
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
