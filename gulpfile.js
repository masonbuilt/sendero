var gulp = require('gulp');
var sass = require('gulp-sass');
var plumber = require('gulp-plumber');
var sourcemaps = require('gulp-sourcemaps');
var notify = require('gulp-notify');
var gutil = require('gulp-util');
var browserSync = require('browser-sync');
var rename = require('gulp-rename');
var autoprefixer = require('gulp-autoprefixer');
var concat = require('gulp-concat');
var styleguide = require('sc5-styleguide');
var del = require('del');
var minifyCss = require('gulp-minify-css');
var uglify = require('gulp-uglify');
var image = require('gulp-image');

// Paths
var outputPath = 'app/assets/';
var outputPathImages = outputPath + 'images/';
var outputPathStylesheets = outputPath + 'stylesheets/';
var outputPathJavascripts = outputPath + 'javascripts/';
var outputPathStyleguide = outputPath + 'styleguide';
var inputPath = 'src/';
var inputPathImages = inputPath + 'images/';
var inputPathStylesheets = inputPath + 'stylesheets/';
var inputPathJavascripts = inputPath + 'javascripts/';

// Browser definitions for autoprefixer
var autoprefixerOptions = {
  browsers: ['last 2 versions', '> 5%', 'Firefox ESR']
};

// Static Server + watching scss/html files
gulp.task('serve', ['clean', 'compile-css', 'compile-javascript', 'move-images',], function() {

    browserSync.init({
        proxy: "localhost:3000"
    });

    gulp.watch(inputPathStylesheets + "**/*.scss", ['compile-css']);
    // gulp.watch(inputPathJavascripts + "**/*.js", ['compile-javascript']);
    gulp.watch(inputPathImages + "**/*", ['move-images']);
});

// Compile CSS
gulp.task('compile-css', function() {

    return gulp.src(inputPathStylesheets + 'application.scss')
        .pipe(sourcemaps.init())
        .pipe(sass({
          style: 'expanded',
        }).on('error', notify.onError(function (error) {
          return "Problem file : " + error.message;
        })))
        .pipe(autoprefixer(autoprefixerOptions))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(outputPathStylesheets))
        .pipe(browserSync.stream());
});

// Minify CSS
gulp.task('build-css', function() {

    return gulp.src(inputPathStylesheets + 'application.scss')
        .pipe(sass({
          style: 'compressed',
        }).on('error', notify.onError(function (error) {
          return "Problem file : " + error.message;
        })))
        .pipe(autoprefixer(autoprefixerOptions))
        .pipe(minifyCss({compatibility: 'ie8'}))
        .pipe(gulp.dest(outputPathStylesheets))
        .pipe(notify({
          title: 'Gulp',
          subtitle: 'success',
          message: 'Sass task',
          sound: "Pop"
        }));
});

// Compile Development JavaScript
gulp.task('compile-javascript', function() {

    gulp.src([outputPathJavascripts + 'libs/**/*.js'])
        .pipe(concat('all.js'))
        .pipe(gulp.dest(outputPathJavascripts))
        .pipe(browserSync.stream());

    gulp.src([inputPathJavascripts + 'application.js'])
        .pipe(concat('application.js'))
        .pipe(gulp.dest(outputPathJavascripts))
        .pipe(browserSync.stream());
});

// Build JS
gulp.task('build-javascript', function() {

    gulp.src([outputPathJavascripts + 'libs/**/*.js'])
        .pipe(concat('all.js'))
        .pipe(uglify())
        .pipe(gulp.dest(outputPathJavascripts));

    gulp.src([inputPathJavascripts + 'application.js'])
        .pipe(concat('application.js'))
        .pipe(uglify())
        .pipe(gulp.dest(outputPathJavascripts));
});

// Move Images
gulp.task('move-images', function() {
  return gulp.src(inputPathImages + '**/*')
    .pipe(gulp.dest(outputPathImages));
});

// Compress Images
gulp.task('build-images', function() {
  return gulp.src(inputPathImages + '**/*')
    .pipe(image({svgo: false}))
    .pipe(gulp.dest(outputPathImages));
});

// Clean up Temp
gulp.task('clean', function () {
  return del.sync([
    outputPathImages + '*',
    // outputPathJavascripts + 'application.js',
    outputPathStylesheets + 'application.css'
  ], {force: true});
});

// styleguide

gulp.task('styleguide:generate', function() {
  return gulp.src(inputPathStylesheets + '**/*.scss')
    .pipe(styleguide.generate({
        title: 'My Styleguide',
        server: true,
        disableEncapsulation: true,
        port: 5000,
        rootPath: outputPathStyleguide,
        overviewPath: 'README.md'
      }))
    .pipe(gulp.dest(outputPathStyleguide));
});

gulp.task('styleguide:applystyles', function() {
  return gulp.src(inputPathStylesheets + 'application.scss')
    .pipe(sass({
      errLogToConsole: true
    }))
    .pipe(styleguide.applyStyles())
    .pipe(gulp.dest(outputPathStyleguide));
});

gulp.task('default', ['styleguide', 'serve'], function() {
  // Start watching changes and update styleguide whenever changes are detected
  // Styleguide automatically detects existing server instance
  gulp.watch([inputPathStylesheets + '**/*.scss'], ['styleguide']);
});

// Styleguide
gulp.task('styleguide', ['styleguide:generate', 'styleguide:applystyles']);

// Default task
gulp.task('watch', ['serve']);

// Build Production
gulp.task('build', ['clean-build', 'build-css', 'build-images']);
