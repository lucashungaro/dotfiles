# Autocomplete
require "irb/completion"
require "rubygems"
require "pp"

# Add all gems installed in the system to the $LOAD_PATH
# so they can be used in Rails console with Bundler
if defined?(::Bundler)
  gem_paths = Dir.glob("/usr/local/lib/ruby/gems/1.9.1/gems/**/lib")
  gem_paths.each do |path|
    $LOAD_PATH << path
  end
end

begin
  require "ap"
rescue LoadError
  puts "=> Unable to load awesome_print"
end

begin
  require "what_methods"
rescue LoadError
  puts "=> Unable to load what_methods"
end

begin
  require "map_by_method"
rescue LoadError
  puts "=> Unable to load map_by_method"
end

IRB.conf[:AUTO_INDENT] = true

# Get all the methods for an object that aren't basic methods from Object
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

# Show Rails log on console
if ENV.include?("RAILS_ENV") && !Object.const_defined?("RAILS_DEFAULT_LOGGER")
  require "logger"
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# Aliases
alias q exit

begin
  require "pry"
  Pry.start
  exit
rescue LoadError => e
  warn "=> Unable to load pry"
end
