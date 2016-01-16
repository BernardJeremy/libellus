var Bookshelf = require("../database/bookshelf");
var Classes = require ("../entities/classes");

module.exports = Bookshelf.Collection.extend({
  model: Classes
});
