require! {
  chai: {expect}
  luxon: {DateTime}
  \../../src/classes/task.ls : Task
  \../../src/functions/short-list.ls : main
}

file = "test#{__filename - /^.*test/}"
describe file, ->
  describe \type, ->
    specify "is function", ->
      expect main .to.be.a \function

  describe "output test", ->
    specify "all empty", ->
      result = []
      main (info: -> result.push it), []
      expect result .to.be.length-of 0

    [
      * \new, \todo
      * \doing, \doing
      * \done, \done
    ].for-each ([status, prefix]) ->
      specify "#{status} task only", ->
        result = []
        tasks = [
          Task.from name: \taro, status: status
          Task.from name: \jiro, status: status
        ]
        main (info: -> result.push it), tasks
        expect result .to.be.length-of 2
        expect result.0 .to.have.string prefix

    specify "has all task", ->
      result = []
      tasks =
        * Task.from name: \taro, status: \new
        * Task.from name: \jiro, status: \doing
        * Task.from name: \saburo, status: \done
        * Task.from name: \siro, status: \done
        * Task.from name: \goro, status: \doing
        * Task.from name: \mutsugoro, status: \new
      main (info: -> result.push it), tasks
      expect result .to.be.length-of 6
      expect result.0 .to.have.string \done
      expect result.2 .to.have.string \todo
      expect result.4 .to.have.string \doing
