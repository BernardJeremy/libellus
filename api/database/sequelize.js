var dbConfig = require('../init');
if (!dbConfig) {
  process.exit();
}

var Sequelize = require('sequelize');

var db = new Sequelize(dbConfig.database, dbConfig.username, dbConfig.password, dbConfig.options);


module.exports = db;
