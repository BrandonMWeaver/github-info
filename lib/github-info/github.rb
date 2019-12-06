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
    if @repositories.size != 0
      i = 0
      puts "repositories:"
      @repositories.each { |repository|
        print "\t"
        print '0' if i < 9
        puts "#{i += 1}. #{repository[:name]}"
      }
    else
      puts "no repositories"
    end
  end
  
  def print_commit_history(index)
    commit_history = GithubInfo::Scraper.get_commit_history(@repositories[index][:href])
    
    puts "commit history:"
    commit_history.each { |commit|
      print "\t"
      print "#{format_date(commit[:date])}: "
      puts commit[:description]
    }
  end
  
  private
  
  def format_date(date)
    if date.split(' ')[1].split(',')[0].to_i < 10
      date_pieces = date.split(' ')
      date = "#{date_pieces[0]} 0#{date_pieces[1]} #{date_pieces[2]}"
    end
    return date
  end
end
