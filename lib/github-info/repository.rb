class GithubInfo::Repository
  
  attr_accessor :commit_history
  attr_reader :name, :href
  
  @@all = []
  
  def initialize(name, href)
    @commit_history = []
    @name = name
    @href = href
    @@all << self
  end
  
  def self.find_or_create_commit_history_by_href(href)
    repository_commit_history = []
    @@all.each do |repository|
      if href == repository.href && repository.commit_history.size > 0
        return repository.commit_history
      elsif href == repository.href
        repository_commit_history = GithubInfo::Scraper.get_commit_history(href)
        repository.commit_history = repository_commit_history
      end
    end
    return repository_commit_history
  end
  
end
