# Updates requirements.txt file
# Run this script at the start of the project 

# Remove version specifiers from requirements.txt
(Get-Content requirements.txt) -replace '==.*', '' | Set-Content requirements.txt

# Upgrade the packages listed in requirements.txt
pip install --upgrade -r requirements.txt

# Regenerate requirements.txt with the updated packages
pip freeze > requirements.txt

Write-Output "Packages updated and requirements.txt regenerated successfully."

