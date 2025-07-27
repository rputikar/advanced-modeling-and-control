# /// script
# requires-python = ">=3.12"
# dependencies = []
# ///

import platform
import shutil
import subprocess
from pathlib import Path


def convert_slides_to_pdf():
    slides_dir = Path("_site/content/slides")

    decktape_cmd = (
        shutil.which("decktape")
        or shutil.which("decktape.cmd")
        or shutil.which("decktape.ps1")
    )
    if not decktape_cmd:
        print(
            "❌ DeckTape not found in PATH. Please install with: npm install -g decktape"
        )
        return

    for slide_path in slides_dir.iterdir():
        if slide_path.is_dir():
            index_file = slide_path / "index.html"
            output_pdf = slide_path / f"{slide_path.name}.pdf"

            if output_pdf.exists():
                print(f"✅ PDF already exists for {slide_path.name}, skipping.")
                continue

            print(f"📄 Converting {index_file} to PDF...")

            try:
                if decktape_cmd.endswith(".ps1"):
                    subprocess.run(
                        [
                            "powershell",
                            "-ExecutionPolicy",
                            "Bypass",
                            "-File",
                            decktape_cmd,
                            "reveal",
                            str(index_file),
                            str(output_pdf),
                        ],
                        check=True,
                    )
                else:
                    subprocess.run(
                        [decktape_cmd, "reveal", str(index_file), str(output_pdf)],
                        check=True,
                    )

                print(f"✅ PDF created: {output_pdf}")
            except subprocess.CalledProcessError as e:
                print(f"❌ DeckTape failed for {index_file}: {e}")


def rename_index_files_in_notes():
    notes_dir = Path("_site/content/notes")
    if not notes_dir.exists():
        print("⚠️ No notes directory found.")
        return

    for folder in notes_dir.iterdir():
        if folder.is_dir():
            for item in folder.iterdir():
                if (
                    item.is_file()
                    and item.stem == "index"
                    and item.suffix.lower() != ".html"
                ):
                    new_name = folder.name + item.suffix
                    new_path = folder / new_name
                    item.rename(new_path)
                    print(f"🔄 Renamed {item.name} → {new_name}")


def main() -> None:
    convert_slides_to_pdf()
    rename_index_files_in_notes()


if __name__ == "__main__":
    main()
