var Bookshelf = require("../database/bookshelf");
var Classes = require ("./classes");

module.exports = Bookshelf.Model.extend({
    tableName: 'teacher',
    schedules : function() {
      return this.hasMany(Classes, "fk_teacher");
    }
});
