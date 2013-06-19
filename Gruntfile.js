'use strict';

module.exports = function (grunt) {

    var path = require('path');
    var fs = require('fs');
    var verbose = grunt.verbose;
    var userhome = process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];

    grunt.initConfig({
        env: {
            home: userhome,
            dotfiles: userhome + '/Dropbox/Private/dotfiles'
        },
        symlink: {
            default: {
                files: [
                    {
                        src: 'bin/*', dest: '/usr/local/bin/'
                    },
                    {
                        src: [
                            '<%= env.dotfiles %>/.*',
                            '!<%= env.dotfiles %>/.DS_Store'
                        ],
                        dest: '<%= env.home %>/'
                        }
                ],
                options: {
                    symlinkext: true,
                    overwrite: true,
                    backup: true
                }
            }
        }
    });

    var makeSymlink = function(targets, options, pathfilter) {
        targets.forEach(function(target) {
            var stat = fs.statSync(target).isFile() ? 'file' : 'dir';
            var path = pathfilter(target, stat);

            if (fs.existsSync(path.dest)) {
                verbose.error('Destination already exist.', path.dest);
                if (options.backup) {
                    var bak = path.dest + '.bak', count = 0;
                    while (fs.existsSync(bak)) {
                        bak = path.dest + '.bak' + ((count++ > 0) ? '.' + count : '');
                    };
                    verbose.writeln('Backup:', path.dest, '->', bak);
                    fs.renameSync(path.dest, bak);
                } else if (options.overwrite) {
                    verbose.writeln('Remove:', path.dest);
                    fs.unlinkSync(path.dest);
                }
            }

            verbose.writeln('Symbolic', stat + ':', path.src, '->', path.dest);
            fs.symlinkSync(path.src, path.dest, stat);
        });
    }

    grunt.task.registerMultiTask('symlink', '', function() {
        var options = this.options();
        var symlinkFilter = function(file) {
            return path.extname(path.basename(file)) !== '.symlink';
        };

        grunt.verbose.writeflags(options, 'Options');

        // make symbolic link with items in manifest.
        this.files.forEach(function(symlink) {
            makeSymlink(grunt.file.expand({filter: symlinkFilter}, symlink.src), options, function(src, stat) {
                return {
                    src: path.resolve(process.cwd(), src),
                    dest: symlink.dest + path.basename(src);
                };
            });
        });

        // make symbolic link with files that has .symlink fileext in subdir.
        if (options.symlinkext) {
            makeSymlink(grunt.file.expand('**/*.symlink'), options, function(src, stat) {
                return {
                    src: path.resolve(process.cwd(), src),
                    dest: userhome + '/.' + (stat === 'file' ? path.basename(src, '.symlink') : path.dirname(src))
                };
            });
        }
    });

    grunt.task.registerTask('source', '', function() {
        var exec = require('child_process').exec;
        var cb = this.async();
        exec('source ~/.zshrc', {}, function (err, stdout, stderr) {
            cb();
        });
    });

    grunt.registerTask('default', [
        'symlink',
        'source'
    ]);
};
