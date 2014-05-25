'use strict';

module.exports = function (grunt) {

    var path = require('path');
    var fs = require('fs');
    var verbose = grunt.verbose;
    var userhome = process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];

    grunt.initConfig({
        env: {
            home: userhome,
            local: './local'
        },
        symlink: {
            options: {
                overwrite: true,
                backup: true
            },
            default: {
                options: {
                    rename: function(filename) {
                        return '.' + path.basename(filename, '.symlink');
                    }
                },
                files: [{
                    src: '**/*.symlink', dest: '<%= env.home %>/'
                }],
            },
            bin: {
                files: [{
                    src: 'bin/*', dest: '/usr/local/bin/'
                }]
            },
            local: {
                options: {
                    rename: function(filename) {
                        return '.' + filename;
                    }
                },
                files: [{
                    src: '<%= env.local %>/*', dest: '<%= env.home %>/'
                }],
            }
        }
    });

    var makeSymlink = function(targets, options, pathfilter) {
        targets.forEach(function(target) {
            verbose.writeln('target', target)
            var stat = fs.statSync(target).isFile() ? 'file' : 'dir';
            var path = pathfilter(target, stat);
            verbose.writeln('dest', path.dest)
            verbose.writeln('exist', fs.existsSync(path.dest));
            verbose.writeln('Link', path.src, 'to', path.dest);
 
            if (fs.existsSync(path.dest)) {
                if (options.backup) {
                    var bak = path.dest + '.bak', count = 0;
                    while (fs.existsSync(bak)) {
                        bak = path.dest + '.bak' + ((count++ > 0) ? '.' + count : '');
                    };
                    verbose.writeln('Backup', path.dest, 'to', bak);
                    fs.renameSync(path.dest, bak);
                } else if (options.overwrite) {
                    verbose.writeln('Remove', path.dest);
                    fs.unlinkSync(path.dest);
                }
            }
           fs.symlinkSync(path.src, path.dest, stat);
        });
    }

    grunt.task.registerMultiTask('symlink', '', function() {
        var options = this.options();

        grunt.verbose.writeflags(options, 'Options');

        this.files.forEach(function(symlink) {
            makeSymlink(grunt.file.expand({}, symlink.src), options, function(src, stat) {
                var dest = path.basename(src)
                if (options.rename) {
                    dest = options.rename(dest)
                }
                return {
                    src: path.resolve(process.cwd(), src),
                    dest: symlink.dest + dest
                };
            });
        });
    });

    grunt.task.registerTask('source', '', function() {
        var exec = require('child_process').exec;
        var cb = this.async();
        exec('source ~/.zshrc', {}, function (err, stdout, stderr) {
            cb();
        });
    });

    grunt.registerTask('default', [
        'symlink:default',
        'symlink:bin',
        'source'
    ]);
};
