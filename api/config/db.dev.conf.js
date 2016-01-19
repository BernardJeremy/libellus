module.exports = {
  database : process.env.DBNAME || 'libellus',
  username : process.env.DBUSERNAME || 'dev',
  password : process.env.DBPASSWORD || 'dev1',
  options  : {
    host     : process.env.DBHOST || 'localhost',
    dialect  : 'postgres',
    logging  : false
  }
};
