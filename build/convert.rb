require 'open-uri'
require 'openssl'

class Convert

  BOOTSTRAP_BRANCH = "2.0-wip"

  # Files commented out below either fail conversion or require hand editing after being converted
  LESS_FILE_NAMES = [
    'reset',
    'variables',
    #'mixins', #
    'scaffolding',
    'grid',
    'layouts',

    #'type', #
    #'code', #
    'forms',
    'tables',

    # Components: Common
    'sprites',
    'dropdowns',
    'wells',
    'component-animations',
    'close',

    # Components: Nav
    'navs',
    'navbar',
    'breadcrumbs',
    'pagination',
    'pager',

    # Components: Popovers
    'modals',
    #'tooltip', #
    #'popovers', #

    # Components: Buttons & Alerts
    'buttons',
    'button-groups',
    'alerts',

    # Components: Misc
    'thumbnails',
    'labels',
    #'progress-bars', #
    'accordion',
    'carousel',
    'hero-unit',

    # Utility classes
    'utilities',

    # Responsive
    #'responsive' #
  ]


  def process
    LESS_FILE_NAMES.each do |name|
      # Retrieve and save the original LESS version (for posterity)
      file = open_git_file(less_file_url(name))
      save_file("less/#{name}", file, 'less')
      # Convert and save the SCSS version
      file = convert(file)
      save_file("_#{name}", file, 'scss')
    end
    # Convert and save the SASS version
    self.create_sass_files
  end
  
  def create_sass_files
    scss_file_path = 'vendor/assets/stylesheets'

    Dir.glob(scss_file_path + '/*').each do |dir|
      file_or_dir = File.open dir

      if File.file? file_or_dir
        convert_scss(file_or_dir)
      else
        Dir.open(dir).each do |file_name|
          file = File.open("#{file_or_dir.path}/#{file_name}")
          next unless File.fnmatch?('**.scss', file_name)
          convert_scss(file, '/bootstrap')
        end
      end
    end
  end

private
  
  def less_file_url(file_name)
    "https://raw.github.com/twitter/bootstrap/#{BOOTSTRAP_BRANCH}/less/#{file_name}.less"
  end

  #OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  def open_git_file(file)
    open(file).read
  end
  
  def convert(file)
    file = replace_vars(file)
    file = replace_fonts(file)
    file = replace_grads(file)
    file = replace_mixins(file)
    file = replace_includes(file)
    file = replace_spin(file)
    file
  end

  def save_file(name, content, type='scss')
    f = File.open("vendor/assets/stylesheets/bootstrap/#{name}.#{type}", "w+")
    f.write(content)
    f.close
    puts "Processed #{name}.#{type}\n"
  end
  

  def process_mixins
    file = open_git_file(less_file_url('mixins'))
    file = replace_mixins(file)
    save_file('_mixins', file)
  end
  

  def replace_vars(less)
    less.gsub(/@/, '$')
  end

  def replace_fonts(less)
    less.gsub(/#font \> \.([\w-]+)/, '@include \1')
  end

  def replace_grads(less)
    less.gsub(/#gradient \> \.([\w-]+)/, '@include gradient-\1')
  end

  def replace_mixins(less)
    less.gsub(/^\.([\w-]*)(\(.*\))([\s\{]+)$/, '@mixin \1\2\3')
  end

  def replace_includes(less)
    less.gsub(/\.([\w-]*)(\(.*\));?/, '@include \1\2;')
  end

  def replace_spin(less)
    less.gsub(/spin/, 'adjust-hue')
  end
                   
  def convert_less(file='')
    #system("sass-convert --from less #{File.basename(file)} #{File.basename(file, ".less")}.scss")
    #system("sass-convert --from less --to scss --recursive stylesheets_less")
  end
  
  def convert_scss(file, folder='')
    system("sass-convert #{file.path} #{File.dirname(file.path)}/sass/#{File.basename(file.path, 'scss')}sass")
    puts "Processed #{File.basename(file.path, 'scss')}sass\n"
  end

end

Convert.new.process
