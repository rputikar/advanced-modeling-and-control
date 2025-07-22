# /// script
# requires-python = ">=3.12"
# dependencies = []
# ///

import subprocess
from pathlib import Path


def main() -> None:
    slides_dir = Path("_site/content/slides")

    for slide_path in slides_dir.iterdir():
        if slide_path.is_dir():
            index_file = slide_path / "index.html"
            output_pdf = slide_path / f"{slide_path.name}.pdf"

            if output_pdf.exists():
                print(f"✅ PDF already exists for {slide_path.name}, skipping.")
            else:
                print(f"📄 Converting {index_file} to PDF...")
                try:
                    subprocess.run(
                        ["decktape", "reveal", str(index_file), str(output_pdf)],
                        check=True,
                    )
                    print(f"✅ PDF created: {output_pdf}")
                except subprocess.CalledProcessError as e:
                    print(f"❌ DeckTape failed for {index_file}: {e}")


if __name__ == "__main__":
    main()
