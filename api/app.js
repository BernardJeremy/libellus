var http = require('http');
var url = require('url');
var querystring = require('querystring');
var express = require('express');

var app = express();

var server = http.createServer(function(req, res) {
    var params = querystring.parse(url.parse(req.url).query);

    res.writeHead(200, {"Content-Type": "text/plain"});
    res.write('Everything went fine ! HAHAHAHAHAHAH');
    res.end();

});
server.listen(80);