const fs = require('fs');
const path = require('path');

const srcDir = path.resolve(__dirname, '../../../skills');
const destDir = path.resolve(__dirname, '../skills');

function copyRecursiveSync(src, dest) {
  const exists = fs.existsSync(src);
  const stats = exists && fs.statSync(src);
  const isDirectory = exists && stats.isDirectory();
  
  if (isDirectory) {
    if (!fs.existsSync(dest)) {
      fs.mkdirSync(dest, { recursive: true });
    }
    fs.readdirSync(src).forEach((childItemName) => {
      copyRecursiveSync(
        path.join(src, childItemName),
        path.join(dest, childItemName)
      );
    });
  } else {
    fs.copyFileSync(src, dest);
  }
}

function copySkills() {
  console.log(`Copying skills from: ${srcDir} -> ${destDir}`);
  if (!fs.existsSync(srcDir)) {
    console.error(`Source directory does not exist: ${srcDir}`);
    process.exit(1);
  }

  if (!fs.existsSync(destDir)) {
    fs.mkdirSync(destDir, { recursive: true });
  }

  const items = fs.readdirSync(srcDir);
  let count = 0;
  items.forEach((item) => {
    if (item.startsWith('signals-')) {
      const srcPath = path.join(srcDir, item);
      const destPath = path.join(destDir, item);
      console.log(`- Copying skill: ${item}`);
      copyRecursiveSync(srcPath, destPath);
      count++;
    }
  });

  console.log(`Successfully copied ${count} skills to VS Code extension.`);
}

copySkills();
