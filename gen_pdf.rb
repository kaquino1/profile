require 'grover'

# Ensure Jekyll has built the static site
system('jekyll build')

# Read the generated HTML from the _site directory
html_file = '_site/resume.html'

unless File.exist?(html_file)
  puts "Error: #{html_file} not found. Make sure Jekyll has built the site."
  exit 1
end

html_content = File.read(html_file)

# Convert the HTML content into a PDF with proper options
grover = Grover.new(html_content)

# Set the PDF options to control page size, margins, and background printing
pdf = grover.to_pdf(
  format: 'A4',                # Explicit page size
  display_header_footer: false,
  margin: {
    top: '0cm',                # No margin on top
    right: '0cm',              # No margin on right
    bottom: '0cm',             # No margin on bottom
    left: '0cm'                # No margin on left
  },
  print_background: true,      # Ensure backgrounds are printed
  landscape: false,            # Ensure portrait orientation
  wait_for: 'body'             # Wait for body to fully load
)

# Save the PDF
output_file = 'assets/resume.pdf'
File.open(output_file, 'wb') { |file| file.write(pdf) }

puts "PDF successfully generated: #{output_file}"
