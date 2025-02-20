require 'prawn'
require 'yaml'

# Load YAML data (You would replace this with the actual path to your resume.yaml file)
resume_data = YAML.load_file('_data/resume.yaml')

Prawn::Document.generate('assets/resume.pdf', margin: [20, 35, 20, 35]) do |pdf|

  # Register the custom fonts
  pdf.font_families.update("SF-Pro-Text" => {
    normal: 'assets/fonts/SF-Pro-Text-Regular.otf',
    bold: 'assets/fonts/SF-Pro-Text-Bold.otf',
    italic: 'assets/fonts/SF-Pro-Text-RegularItalic.otf',
    bold_italic: 'assets/fonts/SF-Pro-Text-BoldItalic.otf'
  })
  
  pdf.font_families.update("SF-Pro-Display" => {
    normal: 'assets/fonts/SF-Pro-Display-Regular.otf',
    bold: 'assets/fonts/SF-Pro-Display-Medium.otf',
    italic: 'assets/fonts/SF-Pro-Display-Italic.otf',
    bold_italic: 'assets/fonts/SF-Pro-Display-MediumItalic.otf'
  })

  pdf.default_leading 3
  pdf.line_width = 1.5

  # Name - Centered
  pdf.font "SF-Pro-Display"
  pdf.text "#{resume_data['name']}", inline_format: true, size: 26, align: :center
  pdf.move_down 5

  
  # Contact Info - Centered
  pdf.font "SF-Pro-Text"
  pdf.text "#{resume_data['contact']['email']} | #{resume_data['contact']['phone']} | #{resume_data['contact']['location']}", size: 11.5, align: :center
  pdf.move_down 5
  pdf.text "<link href='https://#{resume_data['contact']['github']}'><color rgb='#0D6EFD'>#{resume_data['contact']['github']}</color></link> | <link href='https://#{resume_data['contact']['linkedin']}'><color rgb='#0D6EFD'>#{resume_data['contact']['linkedin']}</color></link>", 
    inline_format: true, size: 11.5, align: :center

  

  pdf.move_down 5

  
  # Summary - Section Header (use bold)
  pdf.font "SF-Pro-Display"
  pdf.text "<b>Summary</b>", inline_format: true, size: 16, align: :left
  pdf.font "SF-Pro-Text"
  pdf.stroke_horizontal_rule
  pdf.move_down 7
  pdf.text resume_data['summary'], size: 11.5, align: :left
  pdf.move_down 10

  # Work Experience Section (use bold for section header)
  pdf.font "SF-Pro-Display"
  pdf.text "<b>Work Experience</b>", inline_format:true, size: 16, align: :left
  pdf.font "SF-Pro-Text"
  pdf.stroke_horizontal_rule
  pdf.move_down 7
  resume_data['experience'].each do |job|
    # Left-aligned content inside float block
    pdf.float do
      pdf.text "<b>#{job['company']}</b>", inline_format: true, size: 11.5, align: :left
    end

    # Manually position the right-aligned content
    pdf.text job['location'], size: 11.5, align: :right

    job['roles'].each do |role|
      pdf.float do
        pdf.text role['title'], size: 11.5, align: :left
      end
  
      # Manually position the right-aligned content
      pdf.text role['years'], size: 11.5, align: :right

      pdf.move_down 2
      role['details'].each do |detail|
        pdf.text "• #{detail}", size: 11.5, align: :left, indent_paragraphs: 10
      end
      pdf.move_down 5
    end
  end
  pdf.move_down 10

  # Education Section (use bold for section header)
  pdf.font "SF-Pro-Display"
  pdf.text "<b>Education</b>", inline_format: true, size: 16, align: :left
  pdf.font "SF-Pro-Text"
  pdf.stroke_horizontal_rule
  pdf.move_down 7
  resume_data['education'].each do |edu|
    # Left-aligned content inside float block
    pdf.float do
      pdf.text "<b>#{edu['institution']}</b> | #{edu['location']}", inline_format: true, size: 11.5, align: :left
    end

    # Manually position the right-aligned content
    pdf.text edu['year'], size: 11.5, align: :right

    pdf.move_down 2
    edu['degree'].each do |item|
      pdf.text "#{item}", size: 11.5, align: :left
    end
    pdf.move_down 5
  end
  pdf.move_down 10

  # Technical Skills Section (use bold for section header)
  pdf.font "SF-Pro-Display"
  pdf.text "<b>Technical Skills</b>", inline_format: true, size: 16, align: :left
  pdf.font "SF-Pro-Text"
  pdf.stroke_horizontal_rule
  pdf.move_down 7
  resume_data['skills'].each do |skill|
    # Format category as bold and items as regular
    pdf.text "<b>#{skill['category']}:</b> #{skill['items'].join(', ')}", inline_format: true, size: 11.5
    pdf.move_down 5
  end
end
