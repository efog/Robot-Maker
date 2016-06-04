var gulp = require('gulp');
var jasmine = require('gulp-jasmine');

gulp.task('jasmine', function () {
    gulp.src('spec/**/*spec.js')
        .pipe(jasmine({ verbose: true, includeStackTrace: true }));
});
gulp.task('watch', function () {
    gulp.watch(['spec/**/*.pegjs', 'spec/**/*.fctry', 'spec/**/*spec.js'], ['jasmine']);
});