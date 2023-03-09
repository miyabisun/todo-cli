require! {
  \./list
  \./next
  \./open
  \./start
  \./end
  \./pause
  \./remove
}

module.exports = (program) ->
  [list, next, open, start, end, pause, remove]
    .for-each (cb) -> cb program
