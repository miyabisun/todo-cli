// Generated by LiveScript 1.5.0
var R, load, relativeTime;
R = require('ramda');
load = require('../modules/tasks');
relativeTime = require('../modules/relative-time');
module.exports = function(args, _, log, path){
  var this$ = this;
  return R.when(function(it){
    return it;
  }, function(arg$){
    var task;
    task = arg$[0];
    return log.info(task.name + " (" + relativeTime(task.modified) + ")");
  })(
  function(it){
    return it.doing || it['new'];
  }(
  R.groupBy(function(it){
    return it.status;
  })(
  load(path).tasks)));
};