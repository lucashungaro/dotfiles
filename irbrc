# Autocomplete
require "irb/completion"
require "rubygems"
require "pp"

# Add all gems installed in the system to the $LOAD_PATH so they can be used in Rails console with Bundler
if defined?(::Bundler)
  current_ruby_version = `rbenv version`.split(" ").first
  gem_paths = Dir.glob("#{ENV["HOME"]}/.rbenv/versions/#{current_ruby_version}/lib/ruby/gems/**/gems/*/lib")
  gem_paths.each do |path|
    $LOAD_PATH << path
  end
end

begin
  require "wirble"
  Wirble.init
  Wirble.colorize
rescue LoadError
  puts "Failed to initialize Wirble"
end

begin
  require "ap"
rescue LoadError
  puts "Failed to initialize awesome_print"
end

begin
  require "looksee"
rescue LoadError
  puts "Failed to initialize Looksee"
end


IRB.conf[:AUTO_INDENT] = true

# Get all the methods for an object that aren"t basic methods from Object
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

if ENV.include?("RAILS_ENV") && !Object.const_defined?("RAILS_DEFAULT_LOGGER")
  require "logger"
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# Misc functions

# from http://themomorohoax.com/2009/03/27/irb-tip-load-files-faster
def ls
  %x{ls}.split("\n")
end

def cd(dir)
  Dir.chdir(dir)
  Dir.pwd
end

def pwd
  Dir.pwd
end

def rl(file_name = nil)
  if file_name.nil?
    if !@recent.nil?
      rl(@recent)
    else
      puts "No recent file to reload"
    end
  else
    file_name += ".rb" unless file_name =~ /\.rb/
    @recent = file_name
    load "#{file_name}"
  end
end

def copy(str)
  IO.popen("pbcopy", "w") { |f| f << str.to_s }
end

def paste
  `pbpaste`
end

def ep
  eval(paste)
end

# Aliases
alias q exit