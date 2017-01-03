const fs = require('fs');
const path = require('path');
const globby = require('globby');
const pify = require('pify');

const home = process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];
const pFs = pify(fs);

function stripExtname(p) {
  return `${path.basename(p, path.extname(p))}`;
}

function renameExists(target) {
  return globby(target + '*').then(files => {
    files.forEach(f => pFs.renameSync(f, `${f}.bak`));
    return files;
  });
}

function symlink(manifest, opts) {
  opts = Object.assign({
    strip: false
  }, opts);

  globby(manifest).then(items => {
    Promise.all(items.map(src => {
      const dest = path.join(home, `.${opts.strip ? stripExtname(src) : src}`);
      return renameExists(dest).then(bak => {
        console.log(`Create a link to ${dest} ${bak.length > 0 ? 'with backup' : ''}`);
        return pFs.symlink(path.resolve(src), dest);
      });
    }));
  });
}

symlink([
  '**/*.symlink',
  '/Users/ragingwind/Google Drive/Users/Jimmy Moon/DotFiles/*'
], {strip: true});
