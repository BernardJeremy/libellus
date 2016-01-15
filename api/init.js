var dbConfig;
try {
    // Look for dev conf for local development
    dbConfig = require('./config/db.dev.conf.js');
} catch(e) {
    try {
        // production conf?
        dbConfig = require('./config/db.conf.js');
    } catch(e) {
        console.log('Startup failed. No db config file found.');
        module.exports = false;
        return ;
    }
}

module.exports = dbConfig;
