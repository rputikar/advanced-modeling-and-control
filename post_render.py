# /// script
# requires-python = ">=3.12"
# dependencies = []
# ///

import os
import platform
import shutil
import subprocess
from pathlib import Path


def _find_decktape():
    # 1) Direct on PATH (cmd/ps1 variants on Windows)
    for name in ("decktape", "decktape.cmd", "decktape.ps1"):
        p = shutil.which(name)
        if p:
            return ("direct", p)

    # 2) Project-local node_modules/.bin
    local_bin = Path("node_modules") / ".bin"
    if platform.system() == "Windows":
        for cand in ("decktape.cmd", "decktape.ps1", "decktape"):
            lp = local_bin / cand
            if lp.exists():
                return ("direct", str(lp))
    else:
        lp = local_bin / "decktape"
        if lp.exists():
            return ("direct", str(lp))

    # 3) npx (preferable fallback)
    if shutil.which("npx"):
        return ("npx", "npx")

    # 4) Try npm global prefix/bin
    if shutil.which("npm"):
        try:
            prefix = subprocess.check_output(["npm", "prefix", "-g"], text=True).strip()
            if platform.system() == "Windows":
                # Windows global bin is typically %APPDATA%\npm
                appdata = os.environ.get("APPDATA")
                if appdata:
                    cand = Path(appdata) / "npm" / "decktape.cmd"
                    if cand.exists():
                        return ("direct", str(cand))
                    cand = Path(appdata) / "npm" / "decktape.ps1"
                    if cand.exists():
                        return ("powershell", str(cand))
            else:
                cand = Path(prefix) / "bin" / "decktape"
                if cand.exists():
                    return ("direct", str(cand))
        except Exception:
            pass

    return (None, None)


def convert_slides_to_pdf():
    slides_dir = Path("_site/content/slides")
    mode, decktape_path = _find_decktape()

    if not decktape_path:
        print("❌ DeckTape not found. Fix by either:")
        print("   • npm install -g decktape  (and ensure npm bin is on PATH), or")
        print(
            "   • npm i -D decktape        (then use project-local node_modules/.bin), or"
        )
        print("   • rely on npx (install Node/npm).")
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
                if mode == "powershell":
                    subprocess.run(
                        [
                            "powershell",
                            "-ExecutionPolicy",
                            "Bypass",
                            "-File",
                            decktape_path,
                            "reveal",
                            str(index_file),
                            str(output_pdf),
                        ],
                        check=True,
                    )
                elif mode == "npx":
                    subprocess.run(
                        ["npx", "decktape", "reveal", str(index_file), str(output_pdf)],
                        check=True,
                    )
                else:
                    subprocess.run(
                        [decktape_path, "reveal", str(index_file), str(output_pdf)],
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
