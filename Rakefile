require 'rake'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  @executables = %w(git-publish-branch git-rank-contributors git-show-merges git-wtf edit_gem)
  Dir['*'].each do |file|
    next if %w(Rakefile README LICENSE).include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  give_execute_permission(file) if @executables.include? file
end

def give_execute_permission(file)
  puts "giving execute permissions to ~/.#{file}"
  system %Q{chmod 755 "$HOME/.#{file}"}
end
