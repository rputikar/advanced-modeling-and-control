const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

// Search for subfolders within ./content
const contentPath = './_site/content/slides';
const subfolders = fs.readdirSync(contentPath, { withFileTypes: true })
  .filter(dirent => dirent.isDirectory())
  .map(dirent => `${contentPath}/${dirent.name}`);

// Convert index.html files to PDF using DeckTape
subfolders.forEach(subfolder => {
  const indexPath = path.join(subfolder, 'index.html');
  const folderName = path.basename(subfolder);
  const pdfPath = path.join(subfolder, `${folderName}.pdf`);

  // Execute DeckTape
  try {
    execSync(`decktape reveal ${indexPath} ${pdfPath}`, { stdio: 'inherit' });
    console.log(`DeckTape successfully executed on ${indexPath}`);
  } catch (error) {
    console.error(`Error running DeckTape on ${indexPath}: ${error}`);
  }
});

