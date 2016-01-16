var Bookshelf = require("../database/bookshelf");
var Subject = require ("./subjects");

module.exports = Bookshelf.Model.extend({
  tableName: 'class'
});
