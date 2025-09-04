# Build script for CV
# Usage: .\build.ps1

Write-Host "🚀 Building CV..." -ForegroundColor Green

# Create output directory if it doesn't exist
if (!(Test-Path "output")) {
    New-Item -ItemType Directory -Path "output" | Out-Null
    Write-Host "📁 Created output directory" -ForegroundColor Blue
}

# Check if Quarto is installed
if (!(Get-Command quarto -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Quarto not found. Please install Quarto first." -ForegroundColor Red
    Write-Host "   Download from: https://quarto.org/docs/get-started/" -ForegroundColor Yellow
    exit 1
}

# Check if the main template file exists
if (!(Test-Path "cv-template.qmd")) {
    Write-Host "❌ cv-template.qmd not found in current directory." -ForegroundColor Red
    exit 1
}

# Render the CV
Write-Host "📄 Rendering CV to PDF..." -ForegroundColor Blue
try {
    quarto render cv-template.qmd
    
    # Move generated files to output directory
    if (Test-Path "cv-template.pdf") {
        Move-Item "cv-template.pdf" "output/" -Force
        Write-Host "✅ CV successfully generated!" -ForegroundColor Green
        Write-Host "📁 Output file: output/cv-template.pdf" -ForegroundColor Cyan
    }
    
    # Clean up any temporary LaTeX files
    Get-ChildItem -Name "cv-template.*" | Where-Object { $_ -notlike "*.qmd" } | ForEach-Object { 
        if (Test-Path $_) { Remove-Item $_ -Force }
    }
    
    # Check if PDF was created
    if (Test-Path "output/cv-template.pdf") {
        Write-Host "🎉 Your CV is ready!" -ForegroundColor Green
        
        # Ask if user wants to open the PDF
        $response = Read-Host "Would you like to open the PDF? (y/n)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            Start-Process "output/cv-template.pdf"
        }
    } else {
        Write-Host "⚠️  PDF file was not created. Check for errors above." -ForegroundColor Yellow
    }
        $response = Read-Host "Would you like to open the PDF? (y/n)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            Start-Process "cv-template.pdf"
        }
    } else {
        Write-Host "⚠️  PDF file was not created. Check for errors above." -ForegroundColor Yellow
    }
} catch {
    Write-Host "❌ Error during rendering:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
