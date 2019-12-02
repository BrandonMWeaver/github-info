class GithubInfo::Github
  def initialize(github_name)
    scraper = GithubInfo::Scraper.new(github_name)
    @name = scraper.github_info[:user_info][:name]
    @contributions = scraper.github_info[:user_info][:contributions]
    @repositories = scraper.github_info[:repositories]
  end
  
  def print_name
    if @name != ""
      puts @name
    else
      puts "name unavailable"
    end
  end
  
  def print_contributions
    puts "#{@contributions} contributions in the last year"
  end
  
  def print_repos
    i = 0
    puts "repositories:"
    @repositories.each { |repository|
      print "\t"
      print '0' if i < 9
      puts "#{i += 1}. #{repository}"
    }
  end
end
