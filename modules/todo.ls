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
  |> R.set _, task, todo
  |> save

new-id = (todo) ->
  ids = todo.map (.id)
  for i from 1 to Infinity
    return i unless i in ids

add = ({name, type, url}) ->
  now = cdate!.text!
  if task = find-by type, name
    return update {...task, started: no, done: no, updated: now}
  save [...list!, {
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

remove-by = (type, name) ->
  unless task = find-by type, name
    console.error "not found task:", {type, name}
    return
  remove task.id

start = (id) ->
  if task = list!.find (.id is id)
    now = cdate!.text!
    update {...task, started: yes, done: no, updated: now}

done = (id) ->
  if task = list!.find (.id is id)
    now = cdate!.text!
    update {...task, started: yes, done: yes, updated: now}

pause = (id) ->
  if task = list!.find (.id is id)
    now = cdate!.text!
    update {...task, started: no, done: no, updated: now}

module.exports = {
  list, find, find-by, add, remove, remove-by
  start, done, pause, save
}
