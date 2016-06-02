var parserMaker = require('../../maker/parser-maker');
describe('parser-maker', function () {
    it('should parse a simple grammar', function () {
        var parser = parserMaker.make("start = ('a' / 'b')+");
    });
});