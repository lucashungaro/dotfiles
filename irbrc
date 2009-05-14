# Autocomplete
require 'irb/completion'
require 'rubygems'
require 'wirble'
require 'pp'

Wirble.init
Wirble.colorize

IRB.conf[:AUTO_INDENT] = true

# Get all the methods for an object that aren't basic methods from Object
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
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
    file_name += '.rb' unless file_name =~ /\.rb/  
    @recent = file_name   
    load "#{file_name}"  
  end  
end

# Aliases
alias q exit