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
var watchify   = require('watchify');
var browserify = require('browserify');
var source     = require('vinyl-source-stream');
var buffer     = require('vinyl-buffer');
var assign     = require('lodash.assign');
var reactify   = require('reactify');
var babelify   = require("babelify");

// Paths
var outputPath = './app/assets/';
var outputPathImages = outputPath + 'images/';
var outputPathStylesheets = outputPath + 'stylesheets/';
var outputPathJavascripts = outputPath + 'javascripts/';
var inputPathImages = 'images/';
var inputPathStylesheets = 'stylesheets/';
var inputPathJavascripts = 'javascripts/';
var outputPathStyleguide = outputPath + 'styleguide';

// Browser definitions for autoprefixer
var autoprefixerOptions = {
  browsers: ['last 2 versions', '> 5%', 'Firefox ESR']
};

// Static Server + watching scss/html files
gulp.task('serve', ['clean', 'compile-css', 'development', 'move-images',], function() {

    browserSync.init({
        proxy: "localhost:3000"
    });

    gulp.watch(inputPathStylesheets + "**/*.scss", ['compile-css']);
    gulp.watch(inputPathJavascripts + "**/*.js", ['compile-javascript']);
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

filesToFuckingInclude = [
  './app/assets/javascripts/App.js',
  './app/assets/javascripts/utils/functions.js',
  './app/assets/javascripts/components/_grade_select.js.jsx',
  './app/assets/javascripts/components/_grade_select_option.js.jsx',
  './app/assets/javascripts/components/_login_page.js.jsx',
  './app/assets/javascripts/components/_modal.js.jsx',
  './app/assets/javascripts/components/_new_route_form.js.jsx',
  './app/assets/javascripts/components/_route_list.js.jsx',
  './app/assets/javascripts/components/_route_list_item.js.jsx',
  './app/assets/javascripts/components/_sign_in_form.js.jsx'
  ]
// add custom browserify options here
var customOpts = {
  entries: filesToFuckingInclude,
  transform: [
    ["reactify", {"es6": true}]
  ], // We want to convert JSX to normal javascript and es6 to es5
  debug: true
};
var opts = assign({}, watchify.args, customOpts);

var production = browserify(opts); 
gulp.task('production', bundleProduction);
production.on('log', gutil.log); // output build logs to terminal

var development = watchify(browserify(opts)); 
gulp.task('development', bundleDevelopment);
development.on('update', bundleDevelopment); // on any dep update, runs the bundler
development.on('log', gutil.log); // output build logs to terminal

function bundleDevelopment() {
  return development.bundle()
    // log errors if they happen
    .on('error', function(err){
      console.log(err.message);
    })
    .pipe(source('react-bundle.js'))
    // optional, remove if you don't need to buffer file contents
    .pipe(buffer())
    // optional, remove if you dont want sourcemaps
    .pipe(sourcemaps.init({loadMaps: true})) // loads map from browserify file
       // Add transformation tasks to the pipeline here.
    .pipe(sourcemaps.write('./')) // writes .map file
    .pipe(gulp.dest('./app/assets/javascripts'));
}

function bundleProduction() {
  return production.bundle()
    // log errors if they happen
    .on('error', function(err){
      console.log(err.message);
    })
    .pipe(source('react-bundle.js'))
    // optional, remove if you don't need to buffer file contents
    .pipe(buffer())
    .pipe(uglify())
    .pipe(gulp.dest('./app/assets/javascripts'));
}

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
    outputPathJavascripts + 'application.js',
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
gulp.task('build', ['clean-build', 'build-css', 'development', 'build-images']);
