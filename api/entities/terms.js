var Bookshelf = require("../database/bookshelf");
var Classes = require ("./classes");
module.exports = Bookshelf.Model.extend({
    tableName: 'term',
    class: function() {
      return this.hasMany(Classes, "fk_term");
    }
});
