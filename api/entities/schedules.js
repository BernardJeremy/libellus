var Bookshelf = require("../database/bookshelf");
var Classes = require ("./classes");

module.exports = Bookshelf.Model.extend({
  tableName: 'schedule',
  classes: function() {
    return this.belongsTo(Classes, "fk_class");
  }
});
