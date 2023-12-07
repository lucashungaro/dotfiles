# Autocomplete
require "irb/completion"
require "rubygems"
require "pp"

begin
  require "ap"
rescue LoadError
  puts "=> Unable to load awesome_print"
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
