# Tasks for project

## setup

> Ensure Quarto, Python 3.12, uv, Node.js, and DeckTape are installed. Set up `.venv` and install dependencies. Configure git hooks.

```powershell
# Ensure Quarto
if (-not (Get-Command quarto -ErrorAction SilentlyContinue)) {
    Write-Host "🛠 Installing Quarto..."
    winget install --id Quarto.Quarto -e --silent
} else {
    $quartoVersion = & quarto --version
    Write-Host "✅ Quarto already installed: $quartoVersion"
}

# Ensure Python >= 3.12
if (Get-Command py -ErrorAction SilentlyContinue) {
    $pythonVersion = (& py --version) -replace 'Python ', ''
    if ([Version]$pythonVersion -ge [Version]'3.12') {
        Write-Host "✅ Python already installed: $pythonVersion"
    } else {
        Write-Host "⚠️ Python version too old: $pythonVersion. Installing 3.12..."
        winget install --id Python.Python.3.12 -e --silent
    }
} else {
    Write-Host "🛠 Installing Python 3.12..."
    winget install --id Python.Python.3.12 -e --silent
}

# Ensure uv
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "🛠 Installing uv..."
    winget install --id Astral.uv -e --silent
} else {
    $uvVersion = & uv --version
    Write-Host "✅ uv already installed: $uvVersion"
}

# Ensure Node.js (required for DeckTape)
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "🛠 Installing Node.js..."
    winget install OpenJS.NodeJS.LTS -e --silent
} else {
    $nodeVersion = & node --version
    Write-Host "✅ Node.js already installed: $nodeVersion"
}

# Ensure DeckTape
if (-not (Get-Command decktape -ErrorAction SilentlyContinue)) {
    Write-Host "🛠 Installing DeckTape..."
    npm install -g decktape
} else {
    Write-Host "✅ DeckTape already installed"
}

# Set up .venv
if (-not (Test-Path ".venv")) {
    Write-Host "📦 Creating virtual environment with uv..."
    uv venv
} else {
    Write-Host "✅ .venv already exists"
}

# Activate and install dependencies
$envPath = ".\.venv\Scripts\Activate.ps1"
if (Test-Path $envPath) {
    Write-Host "📦 Activating environment and syncing dependencies..."
    & powershell -NoProfile -ExecutionPolicy Bypass -Command "& { . $envPath; uv sync }"
} else {
    Write-Host "❌ Could not find activation script at $envPath"
    exit 1
}

# Set up git hooks
Write-Host "🔧 Setting up git hooks..."
$hooksDir = ".git/hooks"

# Check if we're in a git repository
if (-not (Test-Path ".git")) {
    Write-Host "⚠️ Not in a git repository - skipping git hooks setup"
} else {
    # Ensure hooks directory exists
    if (-not (Test-Path $hooksDir)) {
        New-Item -Path $hooksDir -ItemType Directory -Force | Out-Null
    }

    # Check if hook files exist
    $preCommitPath = "$hooksDir/pre-commit"
    $bashScriptPath = "$hooksDir/update-qmd.sh"
    $pwshScriptPath = "$hooksDir/update-qmd.ps1"

    if ((Test-Path $preCommitPath) -and (Test-Path $bashScriptPath) -and (Test-Path $pwshScriptPath)) {
        # Make executable on Unix-like systems (if running in Git Bash or WSL)
        if (Get-Command chmod -ErrorAction SilentlyContinue) {
            & chmod +x $preCommitPath
            & chmod +x $bashScriptPath
            Write-Host "✅ Git hooks made executable"
        } else {
            Write-Host "✅ Git hooks found (executable permissions set automatically on Windows)"
        }
    } else {
        $missingFiles = @()
        if (-not (Test-Path $preCommitPath)) { $missingFiles += "pre-commit" }
        if (-not (Test-Path $bashScriptPath)) { $missingFiles += "update-qmd.sh" }
        if (-not (Test-Path $pwshScriptPath)) { $missingFiles += "update-qmd.ps1" }

        Write-Host "⚠️ Missing git hook files: $($missingFiles -join ', ')"
        Write-Host "   Please ensure these files are present in $hooksDir"
    }
}

Write-Host "`n✅ Setup complete."
```

## setup-hooks

> Set up git hooks for .qmd file date-modified updates (standalone hook setup)

```powershell
Write-Host "🔧 Setting up git hooks..."
$hooksDir = ".git/hooks"

# Check if we're in a git repository
if (-not (Test-Path ".git")) {
    Write-Host "❌ Not in a git repository. Please run this from the root of your git repository."
    exit 1
}

# Ensure hooks directory exists
if (-not (Test-Path $hooksDir)) {
    New-Item -Path $hooksDir -ItemType Directory -Force | Out-Null
    Write-Host "📁 Created hooks directory"
}

# Check if hook files exist
$preCommitPath = "$hooksDir/pre-commit"
$bashScriptPath = "$hooksDir/update-qmd.sh"
$pwshScriptPath = "$hooksDir/update-qmd.ps1"

$allFilesExist = (Test-Path $preCommitPath) -and (Test-Path $bashScriptPath) -and (Test-Path $pwshScriptPath)

if ($allFilesExist) {
    # Make executable on Unix-like systems (if running in Git Bash or WSL)
    if (Get-Command chmod -ErrorAction SilentlyContinue) {
        & chmod +x $preCommitPath
        & chmod +x $bashScriptPath
        Write-Host "✅ Git hooks made executable"
    } else {
        Write-Host "✅ Git hooks found (executable permissions set automatically on Windows)"
    }

    Write-Host "✅ Git hooks setup complete!"
    Write-Host "   Your .qmd files will now automatically update their date-modified field on commit."
} else {
    Write-Host "❌ Setup incomplete - missing required files:"
    if (-not (Test-Path $preCommitPath)) { Write-Host "   Missing: $preCommitPath" }
    if (-not (Test-Path $bashScriptPath)) { Write-Host "   Missing: $bashScriptPath" }
    if (-not (Test-Path $pwshScriptPath)) { Write-Host "   Missing: $pwshScriptPath" }

    Write-Host "`nPlease ensure all three hook files are present in the $hooksDir directory:"
    Write-Host "   1. pre-commit (main cross-platform hook)"
    Write-Host "   2. update-qmd.sh (bash version)"
    Write-Host "   3. update-qmd.ps1 (PowerShell version)"
    exit 1
}
```

## render

> Render all Quarto documents and convert Reveal.js slides to PDF

```powershell
quarto render

# Run slide-to-PDF converter using the .venv Python
$pythonExe = ".venv\Scripts\python.exe"
if (Test-Path $pythonExe) {
    & $pythonExe convert_slides_to_pdf.py
} else {
    Write-Host "❌ Python environment not found. Please run 'mask setup' first."
    exit 1
}
```

