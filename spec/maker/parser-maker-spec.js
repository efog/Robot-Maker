var parserMaker = require('../../maker/parser-maker');
describe('parser-maker', function () {
    it('should parse a simple grammar', function () {
        var parser = parserMaker.make("start = ('a' / 'b')+");
        expect(parser).toBeDefined();
        var parseResult = parser.parse('abba');
        expect(parseResult).toBeDefined();
        expect(parseResult.length).toEqual(4);
    });
});