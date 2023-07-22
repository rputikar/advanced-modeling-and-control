# Course Website: Advanced Modeling and Control

Github repository For Advanced modeling and control course .
[The website can be found here.](https://amc.smilelab.dev/)

## Getting Started on windows 10

I use powershell in windows terminal.

Clone the repository.

```
gh repo clone rputikar/advanced-modeling-and-control
```

## Quarto related stuff

Set up python virtual environment and activate it.

```
python -m venv _env
.\_env\Scripts\Activate.ps1
```

Install packages required to run juypter from Quarto

```
python -m pip install -r requirements.txt
```

## Render all files to html

```
quarto render
```

## Tools

### Quarto

Quarto is an open-source scientific and technical publishing system.

Follow installation instructions at [quarto.org](https://quarto.org/)

### Jupyter

Project Jupyter is a non-profit, open-source project, born out of the IPython
Project in 2014 as it evolved to support interactive data science and
scientific computing across all programming languages.

Jupyter will be installed via requirements.txt.

### Python3

Python is a programming language that lets you work more quickly and integrate
your systems more effectively.

Python should be already installed on your machine. Check with

```
python --version
```

If you get an error, install python.

```
winget install Python.Python.3.10
```
