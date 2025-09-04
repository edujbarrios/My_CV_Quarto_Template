-- CV Filters for Quarto - Compatible version
-- This filter generates LaTeX content from YAML parameters

local function escape_latex(str)
    if not str then return "" end
    str = tostring(str)
    str = str:gsub("&", "\\&")
    str = str:gsub("%%", "\\%%")
    str = str:gsub("%$", "\\$")
    str = str:gsub("#", "\\#")
    str = str:gsub("_", "\\_")
    str = str:gsub("%{", "\\{")
    str = str:gsub("%}", "\\}")
    str = str:gsub("~", "\\textasciitilde{}")
    str = str:gsub("%^", "\\textasciicircum{}")
    return str
end

local function to_latex(value)
    if not value then return "" end
    if type(value) == "string" then
        return escape_latex(value)
    else
        return escape_latex(tostring(value))
    end
end

-- Store the generated content globally
local generated_content = {}

function Meta(meta)
    -- Reset content
    generated_content = {}
    
    if meta.params then
        table.insert(generated_content, "\\begin{document}")
        
        -- Header
        local name = to_latex(meta.params.name)
        local position = to_latex(meta.params.position)
        local description = to_latex(meta.params.description)
        local photo = to_latex(meta.params.photo)
        
        table.insert(generated_content, string.format("\\cvheader{%s}{%s}{%s}{%s}", 
            name, position, description, photo))
        
        -- Contact info
        if meta.params.email then
            local email = to_latex(meta.params.email)
            local phone = to_latex(meta.params.phone or "")
            local linkedin = to_latex(meta.params.linkedin or "")
            local github = to_latex(meta.params.github or "")
            local website = to_latex(meta.params.website or "")
            local location = to_latex(meta.params.location or "")
            
            table.insert(generated_content, string.format("\\contactinfo{%s}{%s}{%s}{%s}{%s}{%s}", 
                email, phone, linkedin, github, website, location))
        end
        
        -- Education
        if meta.params.education then
            table.insert(generated_content, "\\cvsection{Educación}")
            for i, edu in ipairs(meta.params.education) do
                local degree = to_latex(edu.degree or "")
                local institution = to_latex(edu.institution or "")
                local year = to_latex(edu.year or "")
                local gpa = to_latex(edu.gpa or "")
                local details = to_latex(edu.details or "")
                
                table.insert(generated_content, string.format("\\cveducation{%s}{%s}{%s}{%s}{%s}", 
                    degree, institution, year, gpa, details))
            end
        end
        
        -- Experience
        if meta.params.experience then
            table.insert(generated_content, "\\cvsection{Experiencia Profesional}")
            for i, exp in ipairs(meta.params.experience) do
                local position = to_latex(exp.position or "")
                local company = to_latex(exp.company or "")
                local period = to_latex(exp.period or "")
                local location = to_latex(exp.location or "")
                
                local achievements = ""
                if exp.achievements then
                    achievements = "\\achievementlist{"
                    for j, achievement in ipairs(exp.achievements) do
                        achievements = achievements .. "\\item " .. to_latex(achievement) .. "\n"
                    end
                    achievements = achievements .. "}"
                end
                
                table.insert(generated_content, string.format("\\cventry{%s}{%s}{%s}{%s}{%s}", 
                    position, company, achievements, period, location))
            end
        end
        
        -- Skills
        if meta.params.skills then
            table.insert(generated_content, "\\cvsection{Habilidades Técnicas}")
            
            local skill_categories = {
                {key = "programming", title = "Lenguajes de Programación"},
                {key = "frameworks", title = "Frameworks y Librerías"},
                {key = "databases", title = "Bases de Datos"},
                {key = "cloud", title = "Cloud y DevOps"},
                {key = "tools", title = "Herramientas"}
            }
            
            for _, category in ipairs(skill_categories) do
                if meta.params.skills[category.key] then
                    table.insert(generated_content, string.format("\\skillsection{%s}{", category.title))
                    for j, skill in ipairs(meta.params.skills[category.key]) do
                        local name = to_latex(skill.name or "")
                        local color = to_latex(skill.color or "000000")
                        table.insert(generated_content, string.format("\\techbadge{%s}{%s} ", name, color))
                    end
                    table.insert(generated_content, "}")
                end
            end
        end
        
        -- Projects
        if meta.params.projects then
            table.insert(generated_content, "\\cvsection{Proyectos Destacados}")
            for i, project in ipairs(meta.params.projects) do
                local name = to_latex(project.name or "")
                local description = to_latex(project.description or "")
                local demo = to_latex(project.demo or "")
                local github = to_latex(project.github or "")
                
                table.insert(generated_content, string.format("\\cvproject{%s}{%s}{%s}{%s}", 
                    name, description, demo, github))
                
                if project.technologies then
                    table.insert(generated_content, "\\textbf{Tecnologías:} ")
                    for j, tech in ipairs(project.technologies) do
                        table.insert(generated_content, string.format("\\texttt{%s} ", to_latex(tech)))
                    end
                    table.insert(generated_content, "\\\\")
                end
                table.insert(generated_content, "\\vspace{0.5em}")
            end
        end
        
        -- Certifications
        if meta.params.certifications then
            table.insert(generated_content, "\\cvsection{Certificaciones}")
            for i, cert in ipairs(meta.params.certifications) do
                local name = to_latex(cert.name or "")
                local issuer = to_latex(cert.issuer or "")
                local date = to_latex(cert.date or "")
                local credential = to_latex(cert.credential or "")
                
                table.insert(generated_content, string.format("\\cvcertification{%s}{%s}{%s}{%s}", 
                    name, issuer, date, credential))
            end
        end
        
        -- Congress publications
        if meta.params.congress_publications then
            table.insert(generated_content, "\\cvsection{Publicaciones en Congresos}")
            for i, pub in ipairs(meta.params.congress_publications) do
                local title = to_latex(pub.title or "")
                local conference = to_latex(pub.conference or "")
                local year = to_latex(pub.year or "")
                local location = to_latex(pub.location or "")
                local coauthors = ""
                if pub.coauthors then
                    local authors = {}
                    for j, author in ipairs(pub.coauthors) do
                        table.insert(authors, to_latex(author))
                    end
                    coauthors = table.concat(authors, ", ")
                end
                
                table.insert(generated_content, string.format("\\cvcongress{%s}{%s}{%s}{%s}{%s}", 
                    title, conference, year, location, coauthors))
            end
        end
        
        -- Papers
        if meta.params.papers then
            table.insert(generated_content, "\\cvsection{Artículos Científicos}")
            for i, paper in ipairs(meta.params.papers) do
                local title = to_latex(paper.title or "")
                local journal = to_latex(paper.journal or "")
                local year = to_latex(paper.year or "")
                local volume = to_latex(paper.volume or "")
                local doi = to_latex(paper.doi or "")
                local coauthors = ""
                if paper.coauthors then
                    local authors = {}
                    for j, author in ipairs(paper.coauthors) do
                        table.insert(authors, to_latex(author))
                    end
                    coauthors = table.concat(authors, ", ")
                end
                
                table.insert(generated_content, string.format("\\cvpublication{%s}{%s}{%s}{%s}{%s}{%s}", 
                    title, journal, year, volume, doi, coauthors))
            end
        end
        
        table.insert(generated_content, "\\end{document}")
    end
    
    return meta
end

function Pandoc(doc)
    if #generated_content > 0 then
        local latex_content = table.concat(generated_content, "\n")
        return pandoc.Pandoc({pandoc.RawBlock("latex", latex_content)}, doc.meta)
    end
    return doc
end
