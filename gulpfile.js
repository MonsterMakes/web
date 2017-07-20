'use strict';
const gulp = require('gulp');
const sourcemaps = require("gulp-sourcemaps");
const concat = require("gulp-concat");
const del = require('del');
const connect = require('gulp-connect');

const DIST = "dist";

gulp.task('default', ['clean','buildStaticFiles', 'buildJs']);

gulp.task('connect', ()=> {
  connect.server({
    root: 'dist',
    port: '6969',
    livereload: true
  });
});

gulp.task('watch', ()=> {
    gulp.watch(['src/*','src/**/*'], ['build']);
    gulp.watch([`${DIST}/*`,`${DIST}/**/*`], ()=> {
      return gulp.src(DIST)
        .pipe(connect.reload());
    });
});

gulp.task('serve', ['clean','buildStaticFiles', 'buildJs','connect','watch']);

gulp.task('clean', ()=> {
  return del([DIST+'/*'],{force:true});
});

gulp.task('build', ['buildJs']);

gulp.task('buildStaticFiles',['clean'], ()=> {
    gulp.src([
        'src/app/index.html',
        'src/app/styles/images/favicon.png',
        'src/app/styles/**/*'
    ])
    .pipe(
       gulp.dest(DIST)
   );
});
gulp.task("buildJs", ['buildStaticFiles'], ()=> {
  return gulp.src("src/app/**/*.js")
    .pipe(sourcemaps.init())
    .pipe(concat("main.js"))
    .pipe(sourcemaps.write("."))
    .pipe(gulp.dest(DIST+"/js"));
});
