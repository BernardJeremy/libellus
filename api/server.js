
var dbConfig;
try {
    // Look for dev conf for local development
    dbConfig = require('./config/db.dev.conf.js');
} catch(e) {
    try {
        // production conf?
        dbConfig = require('./config/db.conf.js');
    } catch(e) {
        console.log('Startup failed.  No db config file found.');
        return false;
    }
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
