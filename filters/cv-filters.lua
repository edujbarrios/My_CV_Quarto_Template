-- CV Filters for Quarto
-- This filter processes the YAML metadata and generates LaTeX content

function Meta(meta)
    local content = {}
    
    -- Helper function to escape LaTeX special characters
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
        str = str:gsub("\\", "\\textbackslash{}")
        return str
    end
    
    -- Helper function to convert pandoc string to LaTeX
    local function to_latex(value)
        if not value then return "" end
        if type(value) == "string" then
            return escape_latex(value)
        elseif value.t == "Str" then
            return escape_latex(value.text)
        else
            return escape_latex(tostring(value))
        end
    end
    
    -- Add LaTeX content
    table.insert(content, "\\begin{document}")
    
    -- Header with photo, name, position, and description
    if meta.params then
        local name = to_latex(meta.params.name)
        local position = to_latex(meta.params.position)
        local description = to_latex(meta.params.description)
        local photo = to_latex(meta.params.photo)
        
        table.insert(content, string.format("\\cvheader{%s}{%s}{%s}{%s}", 
            name, position, description, photo))
        
        -- Contact information
        local email = to_latex(meta.params.email)
        local phone = to_latex(meta.params.phone)
        local linkedin = to_latex(meta.params.linkedin)
        local github = to_latex(meta.params.github)
        local website = to_latex(meta.params.website)
        local location = to_latex(meta.params.location)
        
        table.insert(content, string.format("\\contactinfo{%s}{%s}{%s}{%s}{%s}{%s}", 
            email, phone, linkedin, github, website, location))
        
        -- Education section
        if meta.params.education then
            table.insert(content, "\\cvsection{Educación}")
            for _, edu in ipairs(meta.params.education) do
                local degree = to_latex(edu.degree)
                local institution = to_latex(edu.institution)
                local year = to_latex(edu.year)
                local gpa = to_latex(edu.gpa)
                local details = to_latex(edu.details)
                
                table.insert(content, string.format("\\cveducation{%s}{%s}{%s}{%s}{%s}", 
                    degree, institution, year, gpa, details))
            end
        end
        
        -- Experience section
        if meta.params.experience then
            table.insert(content, "\\cvsection{Experiencia Profesional}")
            for _, exp in ipairs(meta.params.experience) do
                local position = to_latex(exp.position)
                local company = to_latex(exp.company)
                local period = to_latex(exp.period)
                local location = to_latex(exp.location)
                
                -- Create achievements list
                local achievements = ""
                if exp.achievements then
                    achievements = "\\achievementlist{"
                    for _, achievement in ipairs(exp.achievements) do
                        achievements = achievements .. "\\item " .. to_latex(achievement) .. " "
                    end
                    achievements = achievements .. "}"
                end
                
                table.insert(content, string.format("\\cventry{%s}{%s}{%s}{%s}{%s}", 
                    position, company, achievements, period, location))
            end
        end
        
        -- Skills section with badges
        if meta.params.skills then
            table.insert(content, "\\cvsection{Habilidades Técnicas}")
            
            if meta.params.skills.programming then
                table.insert(content, "\\skillsection{Lenguajes de Programación}{")
                for _, skill in ipairs(meta.params.skills.programming) do
                    local name = to_latex(skill.name)
                    local color = to_latex(skill.color)
                    table.insert(content, string.format("\\skillbadge{%s}{%s} ", name, color))
                end
                table.insert(content, "}")
            end
            
            if meta.params.skills.frameworks then
                table.insert(content, "\\skillsection{Frameworks y Librerías}{")
                for _, skill in ipairs(meta.params.skills.frameworks) do
                    local name = to_latex(skill.name)
                    local color = to_latex(skill.color)
                    table.insert(content, string.format("\\skillbadge{%s}{%s} ", name, color))
                end
                table.insert(content, "}")
            end
            
            if meta.params.skills.databases then
                table.insert(content, "\\skillsection{Bases de Datos}{")
                for _, skill in ipairs(meta.params.skills.databases) do
                    local name = to_latex(skill.name)
                    local color = to_latex(skill.color)
                    table.insert(content, string.format("\\skillbadge{%s}{%s} ", name, color))
                end
                table.insert(content, "}")
            end
            
            if meta.params.skills.cloud then
                table.insert(content, "\\skillsection{Cloud y DevOps}{")
                for _, skill in ipairs(meta.params.skills.cloud) do
                    local name = to_latex(skill.name)
                    local color = to_latex(skill.color)
                    table.insert(content, string.format("\\skillbadge{%s}{%s} ", name, color))
                end
                table.insert(content, "}")
            end
            
            if meta.params.skills.tools then
                table.insert(content, "\\skillsection{Herramientas}{")
                for _, skill in ipairs(meta.params.skills.tools) do
                    local name = to_latex(skill.name)
                    local color = to_latex(skill.color)
                    table.insert(content, string.format("\\skillbadge{%s}{%s} ", name, color))
                end
                table.insert(content, "}")
            end
        end
        
        -- Projects section
        if meta.params.projects then
            table.insert(content, "\\cvsection{Proyectos Destacados}")
            for _, project in ipairs(meta.params.projects) do
                local name = to_latex(project.name)
                local description = to_latex(project.description)
                local demo = to_latex(project.demo or "")
                local github = to_latex(project.github or "")
                
                table.insert(content, string.format("\\cvproject{%s}{%s}{%s}{%s}", 
                    name, description, demo, github))
                
                -- Add technology badges
                if project.technologies then
                    table.insert(content, "\\textbf{Tecnologías:} ")
                    for _, tech in ipairs(project.technologies) do
                        table.insert(content, string.format("\\texttt{%s} ", to_latex(tech)))
                    end
                    table.insert(content, "\\\\")
                end
                table.insert(content, "\\vspace{0.5em}")
            end
        end
        
        -- Certifications section
        if meta.params.certifications then
            table.insert(content, "\\cvsection{Certificaciones}")
            for _, cert in ipairs(meta.params.certifications) do
                local name = to_latex(cert.name)
                local issuer = to_latex(cert.issuer)
                local date = to_latex(cert.date)
                local credential = to_latex(cert.credential or "")
                
                table.insert(content, string.format("\\cvcertification{%s}{%s}{%s}{%s}", 
                    name, issuer, date, credential))
            end
        end
        
        -- Congress Publications section
        if meta.params.congress_publications then
            table.insert(content, "\\cvsection{Publicaciones en Congresos}")
            for _, pub in ipairs(meta.params.congress_publications) do
                local title = to_latex(pub.title)
                local conference = to_latex(pub.conference)
                local year = to_latex(pub.year)
                local location = to_latex(pub.location)
                local coauthors = ""
                if pub.coauthors then
                    local authors = {}
                    for _, author in ipairs(pub.coauthors) do
                        table.insert(authors, to_latex(author))
                    end
                    coauthors = table.concat(authors, ", ")
                end
                
                table.insert(content, string.format("\\cvcongress{%s}{%s}{%s}{%s}{%s}", 
                    title, conference, year, location, coauthors))
            end
        end
        
        -- Papers section
        if meta.params.papers then
            table.insert(content, "\\cvsection{Artículos Científicos}")
            for _, paper in ipairs(meta.params.papers) do
                local title = to_latex(paper.title)
                local journal = to_latex(paper.journal)
                local year = to_latex(paper.year)
                local volume = to_latex(paper.volume)
                local doi = to_latex(paper.doi or "")
                local coauthors = ""
                if paper.coauthors then
                    local authors = {}
                    for _, author in ipairs(paper.coauthors) do
                        table.insert(authors, to_latex(author))
                    end
                    coauthors = table.concat(authors, ", ")
                end
                
                table.insert(content, string.format("\\cvpublication{%s}{%s}{%s}{%s}{%s}{%s}", 
                    title, journal, year, volume, doi, coauthors))
            end
        end
    end
    
    table.insert(content, "\\end{document}")
    
    -- Convert content to a single RawBlock
    local latex_content = table.concat(content, "\n")
    meta.content = pandoc.RawBlock("latex", latex_content)
    
    return meta
end

-- Process the document and inject the generated content
function Pandoc(doc)
    if doc.meta.content then
        return pandoc.Pandoc({doc.meta.content}, doc.meta)
    end
    return doc
end