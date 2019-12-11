class GithubInfo::Github
  
  attr_reader :user_name, :name, :contributions, :repositories
  
  @@all = []
  
  def initialize(user_name)
    @user_name = user_name
    github_info = GithubInfo::Scraper.scrape(@user_name)
    @name = github_info[:user_info][:name]
    @contributions = github_info[:user_info][:contributions]
    @repositories = github_info[:repositories]
    @@all << self
  end
  
  def self.find_or_create_by_profile_name(user_name)
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
    return GithubInfo::Scraper.get_commit_history(@repositories[index][:href])
  end
  
end
