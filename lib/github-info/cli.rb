class GithubInfo::CLI
  def call
    menu
  end
  
  private
  
  def print_help
    print "\tgit: [profile] -> "
    puts "Retrieves information from a github profile."
    print "\tname -> "
    puts "Outputs the name of the user if one is provided."
    print "\tcontributions -> "
    puts "Outputs the contributions commited by the user within the last year."
    print "\trepos -> "
    puts "Outputs an indexed list of the user's repositories."
    print "\thistory: [repository_index] -> "
    puts "Outputs a list of a repository's commit history."
    print "\texit -> "
    puts "Exit the program."
  end
  
  def print_name
    if @github_profile.name != ""
      puts @github_profile.name
    else
      puts "name unavailable"
    end
  end
  
  def print_contributions
    puts "#{@github_profile.contributions} contributions in the last year"
  end
  
  def print_repositories
    if @github_profile.repositories.size != 0
      puts "repositories:"
      i = 0
      @github_profile.repositories.each do |repository|
        print "\t"
        print '0' if i < 9
        puts "#{i += 1}. #{repository.name}"
      end
    else
      puts "no repositories"
    end
  end
  
  def print_commit_history(index)
    puts "commit history:"
    @github_profile.commit_history(index).each do |commit|
      print "\t"
      print "#{format_date(commit[:date])}: "
      puts commit[:description]
    end
  end
  
  def format_date(date)
    if date.split(' ')[1].split(',')[0].to_i < 10
      date_pieces = date.split(' ')
      date = "#{date_pieces[0]} 0#{date_pieces[1]} #{date_pieces[2]}"
    end
    return date
  end
  
  def menu
    commands = ["name", "contributions", "repos", "history"]
    
    puts "enter 'help' for a list of commands"
    
    loop do
      puts "command:"
      input = gets.strip
      
      if input.split(':')[0].downcase == "git"
        begin
        profile_name = input.split(':')[1].split(' ')[0]
        @github_profile = GithubInfo::Github.find_or_create_by_user_name(profile_name)
        puts "github acquired"
        rescue OpenURI::HTTPError
          puts "github not found"
        rescue NoMethodError
          puts "github not provided"
        end
      
      elsif input.downcase == "help"
        print_help
      
      elsif input.downcase == "name" && @github_profile
        print_name
      
      elsif input.downcase == "contributions" && @github_profile
        print_contributions
      
      elsif input.downcase == "repos" && @github_profile
        print_repositories
      
      elsif input.split(':')[0].downcase == "history" && @github_profile
        begin
        index = input.split(':')[1].split(' ')[0].to_i - 1
        print_commit_history(index)
        rescue OpenURI::HTTPError
          puts "repository not found"
        rescue NoMethodError
          puts "repository not found"
        end
      
      elsif input.downcase == "exit"
        break
        
      elsif commands.include?(input.split(':')[0].downcase)
        puts "command currently unavailable"
      
      else
        puts "unknown command"
      end
    end
  end
  
end
