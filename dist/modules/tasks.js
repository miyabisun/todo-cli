// Generated by LiveScript 1.5.0
var Tasks;
Tasks = require('../classes/tasks');
module.exports = function(path){
  path == null && (path = process.env.HOME + "/.tasks.json");
  return Tasks.load(path);
};