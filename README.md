# Professional CV Template for Quarto

A modern, professional CV template built with **Quarto, LaTeX, and Lua**. Generate stunning PDFs with customizable colors, shields.io-style badges, and professional styling.

By [Eduardo J. Barrios](https://edujbarrios.com)

## ✨ Features

- 🎨 **Professional Design** with customizable colors optimized for PDF viewing
- 📸 **Circular Profile Photo** support
- 📞 **Contact Information** with FontAwesome icons
- 📚 **Comprehensive Sections**: Education, Experience, Projects, Certifications, Publications
- 🏷️ **Custom Skill Badges** using shields.io color schemes
- 🔗 **Interactive Links** for GitHub, LinkedIn, websites

## 🚀 Quick Start

1. **Add your photo**: Save your profile picture at `/images`
2. **Edit your information**: Customize `cv-template.qmd` with your details
3. **Generate PDF**: Run `quarto render cv-template.qmd`


## 📋 Usage Instructions

### Step 1: Add Your Photo
Save your profile picture as `images/profile.jpg`
- **Formats**: JPG, PNG, or PDF
- **Size**: 500x500px (square) recommended
- **Quality**: High resolution for best results

### Step 2: Edit Your Information
Open `cv-template.qmd` and customize:

```latex
# Personal Information
\cvheader{Your Full Name}{Your Professional Title}{Brief professional description}{images/profile.jpg}

# Contact Information  
\contactinfo{email@example.com}{+1 (555) 123-4567}{linkedin.com/in/yourprofile}{github.com/yourusername}{www.yourwebsite.com}{Your City, Country}

# Education
\cveducation{Degree Title}{University Name}{Year Range}{GPA}{Additional details}

# Experience
\cventry{Job Title}{Company Name}{\achievementlist{
\item Your achievement 1 with quantifiable results
\item Your achievement 2 with specific impact
\item Your achievement 3 with measurable outcomes
}}{Date Range}{Location}

# Skills with Custom Badges
\techbadge{Python}{3776ab} \techbadge{JavaScript}{f7df1e} \techbadge{React}{61dafb}
```

### Step 3: Generate Your CV
```bash
# Method 1: Direct Quarto command
quarto render cv-template.qmd
```
```powershell
# Method 2: Using the provided build script for windows
.\build.ps1
```


## 🎨 Color Customization

### Optimized Color Scheme
The template uses colors optimized for PDF viewing:
- **Primary Text**: Professional dark blue (#2C3E50)
- **Secondary Text & Links**: Medium blue (#2E5F8A) - optimized for readability
- **Accent**: Red (#E74C3C)

### Custom Badge Colors
Use the same color format as **shields.io** badges:

```latex
\techbadge{Technology Name}{HEX_COLOR}
```

### Example Badge Usage:
```latex
\skillsection{Programming Languages}{
\techbadge{Python}{3776ab} \techbadge{JavaScript}{f7df1e} \techbadge{TypeScript}{3178c6}
}
```

## 📖 Available Sections

All sections are optional - include only what's relevant:

- ✅ **Header**: Name, title, description, photo
- ✅ **Contact**: Email, phone, social media, location
- ✅ **Education**: Degrees, institutions, GPA, details
- ✅ **Experience**: Positions, companies, achievements, dates
- ✅ **Skills**: Organized categories with custom badges
- ✅ **Projects**: Name, description, technologies, links
- ✅ **Certifications**: Name, issuer, date, verification links
- ✅ **Conference Publications**: Title, conference, location, co-authors
- ✅ **Scientific Papers**: Title, journal, volume, DOI, co-authors

## 🛠️ Requirements

- **Quarto**: Download from [quarto.org](https://quarto.org/docs/get-started/)
- **LaTeX Distribution**: 
  - Windows: MiKTeX or TeX Live
  - macOS: MacTeX
  - Linux: TeX Live

### Installation Commands:
```bash
# Install Quarto
# Windows
winget install quarto

# macOS  
brew install quarto

# Install LaTeX
# Windows
winget install MiKTeX.MiKTeX

# macOS
brew install --cask mactex

# Linux (Ubuntu/Debian)
sudo apt-get install texlive-full
```

## 🔧 Troubleshooting

### Common Issues:

**"Quarto not found"**
- Install Quarto from the official website
- Restart your terminal after installation

**"LaTeX compilation failed"** 
- Install a LaTeX distribution (MiKTeX, TeX Live, or MacTeX)
- Ensure all required packages are installed

**"Unable to load picture"**
- Verify your photo exists at `images/profile.jpg`
- Check file format (JPG, PNG, PDF supported)
- Temporarily remove photo reference to test: `\cvheader{Name}{Title}{Description}{}`

**"Permission denied"**
- Run terminal as administrator (Windows)
- Check file permissions in the project directory


## 🤝 Contributing

Feel free to submit issues, feature requests, or improvements to make this template even better!

## 📄 License

This template is open source and available under the MIT License. However, a credit to the original author would be appreciated. as "Eduardo J. Barrios - https://edujbarrios.com".

---
