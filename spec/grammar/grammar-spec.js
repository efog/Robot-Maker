var parserMaker = require('../../maker/parser-maker');
describe('grammar-maker', function () {
    it('can parse base grammar', function () {
        var fs = require('fs');
        var grammar = fs.readFileSync('./spec/grammar/grammar.pegjs', 'utf8');
        var parser = parserMaker.make(grammar);
        expect(parser).toBeDefined();
        var grammarDesc = fs.readFileSync('./spec/grammar/grammar.fctry', 'utf8');
        parser.parse(grammarDesc);
    });
});