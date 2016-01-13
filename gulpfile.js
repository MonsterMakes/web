var gulp = require('gulp');
var sourcemaps = require("gulp-sourcemaps");
var babel = require("gulp-babel");
var concat = require("gulp-concat");
var del = require('del');

var DIST = "dist";

gulp.task('watch', function() {
    var watcher = gulp.watch(['src/*','src/**/*'], ['default']);
    // watcher.on('change', function(event) {
    //   console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
    // });
});


gulp.task('default', ['clean','buildStaticFiles', 'buildJs'/*,'watch'*/]);

gulp.task('clean', function() {
  return del([DIST+'/*'],{force:true});
});

gulp.task('buildStaticFiles',['clean'], function() {
    gulp.src([
        'src/app/index.html',
        'src/app/styles/images/favicon.png',
        'src/app/styles/**/*'
    ])
    .pipe(
       gulp.dest(DIST)
   );
});
gulp.task("buildJs", ['buildStaticFiles'],function () {
  return gulp.src("src/app/**/*.js")
    .pipe(sourcemaps.init())
    .pipe(babel({
            presets: ['es2015']
        }))
    .pipe(concat("main.js"))
    .pipe(sourcemaps.write("."))
    .pipe(gulp.dest(DIST+"/js"));
});