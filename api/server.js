
var dbConfig = require('./init');
if (!dbConfig) {
  return false;
}

var knex = require('knex')({
        client: 'postgres',
        connection: dbConfig
    });
var express = require('express');
var Bookshelf = require('bookshelf');

var app = express();

require('./routes')(app);

app.listen(80);

console.log('Listening on port 80');
