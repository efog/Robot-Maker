var model = module.exports,
    pegjs = require('pegjs');

/**
 * Make parser off of grammar
 * @param grammar grammar content as string
 */
function make (grammar) {
    var parser = pegjs.buildParser(grammar);

    return parser;
}
model.make = make;
