const fs = require("fs");
const { execSync } = require("child_process");
const path = require("path");

// Search for subfolders within ./content
const contentPath = "./_site/content/slides";
const subfolders = fs
  .readdirSync(contentPath, { withFileTypes: true })
  .filter((dirent) => dirent.isDirectory())
  .map((dirent) => `${contentPath}/${dirent.name}`);

// Convert index.html files to PDF using DeckTape
subfolders.forEach((subfolder) => {
  const folderName = path.basename(subfolder);
  const pdfPath = path.join(subfolder, `${folderName}.pdf`);

  if (fs.existsSync(pdfPath)) {
    // PDF file already exists, skip running DeckTape
    console.log(`PDF already exists for ${folderName}, skipping DeckTape.`);
  } else {
    // Execute DeckTape if the PDF does not exist
    const indexPath = path.join(subfolder, "index.html");
    try {
      execSync(`decktape reveal ${indexPath} ${pdfPath}`, { stdio: "inherit" });
      console.log(`DeckTape successfully executed on ${indexPath}`);
    } catch (error) {
      console.error(`Error running DeckTape on ${indexPath}: ${error}`);
    }
  }
});
