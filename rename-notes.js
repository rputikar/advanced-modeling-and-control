const fs = require('fs');
const path = require('path');

// Search for subfolders within ./content
const contentPath = './_site/content/notes';
const subfolders = fs.readdirSync(contentPath, { withFileTypes: true })
  .filter(dirent => dirent.isDirectory())
  .map(dirent => dirent.name);

// Rename and move index files
subfolders.forEach(folderName => {
  const folderPath = path.join(contentPath, folderName);
  const files = fs.readdirSync(folderPath);
  
  files.forEach(file => {
    const extname = path.extname(file);
    if (file.startsWith('index') && extname !== '.html') {
      const newFilePath = path.join(folderPath, `${folderName}${extname}`);
      fs.renameSync(path.join(folderPath, file), newFilePath);
      console.log(`Renamed ${file} to ${folderName}${extname}`);
    }
  });
});

