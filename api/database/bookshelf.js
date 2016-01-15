var dbConfig = require('../init');
if (!dbConfig) {
  process.exit();
}

var knex = require('knex')({
        client: 'postgres',
        connection: dbConfig
    });

module.exports = require('bookshelf')(knex);
