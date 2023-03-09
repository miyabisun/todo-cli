require! {
  \./list
  \./add
  \./next
  \./open
  \./start
  \./end
  \./pause
  \./remove
  \./reindex
}

module.exports = (program) ->
  [list, add, next, open, start, end, pause, remove, reindex]
    .for-each (cb) -> cb program
