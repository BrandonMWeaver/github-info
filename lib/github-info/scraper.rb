class GithubInfo::Scraper
  
  def self.scrape(profile_name)
    @github_info = {
      user_info: get_user_info(profile_name),
      repositories: get_repositories(profile_name)
    }
    return @github_info
  end
  
  def self.get_commit_history(href)
    commit_history = []
    document = Nokogiri::HTML(open("https://github.com#{href}/commits/master"))
    document.css("div.table-list-cell").each do |commit|
      if commit.css("p a.message.js-navigation-open").text != ""
        commit_hash = {
          description: commit.css("p a.message.js-navigation-open").text,
          date: commit.css("relative-time.no-wrap").text
        }
        commit_history << commit_hash
      end
    end
    return commit_history
  end
  
  private
  
  def self.get_user_info(profile_name)
    user_info = {}
    document = Nokogiri::HTML(open("https://github.com/#{profile_name}"))
    user_info[:name] = document.css("span.p-name.vcard-fullname.d-block.overflow-hidden").text
    user_info[:contributions] = document.css("h2.f4.text-normal.mb-2")[1].text.split(' ')[0]
    return user_info
  end
  
  def self.get_repositories(profile_name)
    repositories = []
    document = Nokogiri::HTML(open("https://github.com/#{profile_name}?tab=repositories"))
    document.css("div.d-inline-block.mb-1 h3 a").each do |repository|
      repository_hash = {
        name: repository.text.split(' ')[0],
        href: repository.attr("href")
      }
      repositories << repository_hash
    end
    return repositories
  end
  
end
