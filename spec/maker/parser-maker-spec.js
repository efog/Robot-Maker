var parserMaker = require('../../maker/parser-maker');
describe('parser-maker', function () {
    it('should parse a simple grammar from file', function () {
        var fs = require('fs');
        var content = fs.readFileSync('./spec/maker/abba-test.pegjs', 'utf8');
        var parser = parserMaker.make(content);
        expect(parser).toBeDefined();
        var parseResult = parser.parse('abba');
        expect(parseResult).toBeDefined();
        expect(parseResult.length).toEqual(4);
    });
});