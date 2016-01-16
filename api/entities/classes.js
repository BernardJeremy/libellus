var Bookshelf = require("../database/bookshelf");
var Schedule = require ("./schedules");
var Teacher = require ("./teachers");

module.exports = Bookshelf.Model.extend({
  tableName: 'class',
  schedules : function() {
    return this.hasMany(Schedule, "fk_class");
  },
  teacher: function() {
    return this.belongsTo(Teacher, "fk_teacher");
  }
});
