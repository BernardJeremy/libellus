Libellus API
============

An API used by the libellus project to retrieve classes and teacher rating for CSULB.

## Features

* Retrieve all classes for a given subject and, optionally, the term (Spring, Winter ...).
* Retrieve all subjects available.
* Retrieve all term available.

## Installation

* Clone the present depot.
* Perform `npm install` to install dependencies.
* Perform `node server.js` to start the API server.

## Endpoints

* <code>GET</code> subjects/ : Return all available subjects.
* <code>GET</code> terms/ : Return all available terms.
* <code>GET</code> subjects/:subjectid/classes?term=:termId :  : Return all available classes for the given subject/term.


## Credits

Project created by [Jeremy Bernard](https://github.com/BernardJeremy), [Guillaume Besson](https://github.com/geekuillaume) and [Adrien Morel](https://github.com/Sevauk)
