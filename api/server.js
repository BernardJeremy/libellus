
var express = require('express');

var app = express();

require('./routes')(app);

app.listen(8080);

console.log('Listening on port 8080');
