class GithubInfo::CLI
  def call
    menu
  end
  
  private
  
  def menu
    commands = ["name", "contributions", "repos", "history"]
    github_name = ""
    
    loop do
      puts "command:"
      input = gets.strip
      
      if input.split(':')[0].downcase == "git"
        begin
        github_name = input.split(':')[1].split(' ')[0]
        @github = GithubInfo::Github.new(github_name)
        puts "github acquired"
        rescue OpenURI::HTTPError
          puts "github not found"
        rescue NoMethodError
          puts "github not provided"
        end
      
      elsif input.downcase == "name" && @github
        @github.print_name
      
      elsif input.downcase == "contributions" && @github
        @github.print_contributions
      
      elsif input.downcase == "repos" && @github
        @github.print_repos
      
      elsif input.split(':')[0].downcase == "history" && @github
        begin
        index = input.split(':')[1].split(' ')[0].to_i - 1
        @github.print_commit_history(index)
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
