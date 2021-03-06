class GithubInfo::Github
  
  attr_reader :user_name, :name, :contributions, :repositories
  
  @@all = []
  
  def initialize(user_name)
    @user_name = user_name
    github_info = GithubInfo::Scraper.scrape(@user_name)
    @name = github_info[:user_info][:name]
    @contributions = github_info[:user_info][:contributions]
    
    @repositories = []
    github_info[:repositories].each do |repository|
      @repositories << GithubInfo::Repository.new(repository[:name], repository[:href])
    end
    
    @@all << self
  end
  
  def self.find_or_create_by_user_name(user_name)
    @@all.each do |profile|
      if user_name == profile.user_name
        return profile
      end
    end
    return self.new(user_name)
  end
  
  def self.all
    return @@all
  end
  
  def commit_history(index)
    return GithubInfo::Repository.find_or_create_commit_history_by_href(@repositories[index].href)
  end
  
  def directory_list(index)
    return GithubInfo::Repository.find_or_create_directory_list_by_href(@repositories[index].href)
  end

end
