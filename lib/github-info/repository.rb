class GithubInfo::Repository
  
  attr_accessor :commit_history
  attr_reader :name, :href
  
  def initialize(name, href)
    @name = name
    @href = href
    @@all << self
  end
  
end
