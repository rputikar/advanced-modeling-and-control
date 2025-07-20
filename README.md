# Advanced Modeling and Control (AMC)

This repository contains the code and course website for the Advanced Modeling and Control unit.
It uses Python, JupyterLab, and Quarto for interactive computation and publishing.

📚 Course website: [https://amc.smilelab.dev](https://amc.smilelab.dev/)

---

## 🚀 Getting Started (Windows 10/11)

### Prerequisites

- [Quarto ≥ 1.7.32](https://quarto.org/docs/get-started/)

  Open-source publishing system for scientific and technical documents.
  All content in this repository is written using Quarto (.qmd files), and rendered to HTML, and PDF.

- [Python 3.12+](https://www.python.org/downloads/)

  - Check with `python --version`
  - Install via: `winget install Python.Python.3.12`

- [uv ≥ 0.1.39](https://github.com/astral-sh/uv)

  uv is a fast, modern Python package manager that replaces pip, venv, and pip-tools.
  It installs dependencies 10–100× faster than pip.

- [PowerShell 7+](https://learn.microsoft.com/en-us/powershell/)

- (Optional) GitHub CLI: `winget install GitHub.cli` provides enhanced workflows for GitHub.

- (Optional) [Mask](https://github.com/jacobdeichert/mask): Task runner using Markdown

  `mask` is a CLI tool that runs tasks defined in a simple `maskfile.md`.
  It enables organized, documented workflows directly from the command line.

  🛠 You must install Mask manually to run tasks.

  📦 Install on Windows:

  ```powershell
  winget install jacobdeichert.mask
  ```

  ✅ Use it to run various setup and rendering tasks. For example:

  ```powershell
  mask setup
  ```

  💡 If you don't want to install `mask`, you can manually follow the commands listed in `maskfile.md`.

### 1. Clone the repository

```powershell
git clone https://github.com/rputikar/advanced-modeling-and-control.git
cd advanced-modeling-and-control
```

### 2. Set up Python environment

- Create and activate the environment:

  ```powershell
  uv venv
  .\.venv\Scripts\Activate.ps1
  ```

- Install dependencies from `pyproject.toml`:

  ```powershell
  uv sync
  ```

  This will create a `.venv` folder and install only the declared dependencies, ensuring a clean, reproducible environment.

- 💡 Adding new packages

  To add a new package to the project, use the following command:

  ```powershell
  uv add <package-name>
  ```

### 4. Check Quarto installation

```powershell
mask ensure-quarto
```

### 5. Render all course materials

```powershell
quarto render
```

## 📦 Quarto Extensions Used

The following Quarto extensions are used in this project:

| Extension                       | Version | Purpose                      |
| ------------------------------- | ------- | ---------------------------- |
| `quarto-ext/fontawesome`        | 1.1.0   | Shortcodes for icons         |
| `quarto-ext/include-code-files` | 1.0.0   | Include external code blocks |
| `quarto-ext/latex-environment`  | 1.1.2   | LaTeX formatting + filters   |
| `quarto-ext/lightbox`           | 0.1.9   | Image lightbox support       |
| `schochastics/academicons`      | 0.2.2   | Academic icon shortcodes     |
| `schochastics/social-share`     | 0.1.0   | Social sharing filters       |

## 📁 Project Structure

```
advanced-modeling-and-control/
│
├── pyproject.toml        # Python environment config
├── maskfile.md           # Task automation (Mask runner)
├── README.md             # Project documentation
├── \*.qmd                # Quarto markdown notebooks
├── .venv/                # Python virtual environment (ignored)
│
├── data/                 # Misc data files
├── \_extensions/         # Quarto extensions
├── bibliography/         # Reference files and citations
├── \_freeze/             # Cache from Quarto builds
├── content/              # Notes, lectures, slides, labs, etc.
├── assets/               # Fonts, images, styles, templates
├── \_site/               # Rendered Quarto website

```

---

## ✍️ License

This project is licensed under the MIT License.  
See the [LICENSE](LICENSE.md) file for full details.
