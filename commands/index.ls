require! {
  \./list
  \./next
  \./open
  \./start
  \./end
  \./pause
}

module.exports = (program) ->
  [list, next, open, start, end, pause]
    .for-each (cb) -> cb program
