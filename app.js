var fs = require('fs');
var parserMaker = require('./maker/parser-maker');

var grammar = fs.readFileSync('./spec/grammar/grammar.pegjs', 'utf8');
var parser = parserMaker.make(grammar);

var grammarDesc = fs.readFileSync('./spec/grammar/grammar.fctry', 'utf8');
var result = parser.parse(grammarDesc);
console.log('done');