var Bookshelf = require("../database/bookshelf");
var Classes = require ("./classes");

module.exports = Bookshelf.Model.extend({
  tableName: 'subject'
});
