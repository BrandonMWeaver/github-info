require "nokogiri"
require "open-uri"

class GithubInfo::Scraper
  attr_reader :github_info
  
  def initialize(github_name)
    @github_name = github_name
    @github_info = {
      user_info: get_user_info,
      repositories: get_repositories
    }
  end
  
  def self.get_commit_history(relative_path)
    commit_history = []
    document = Nokogiri::HTML(open("https://github.com#{relative_path}/commits"))
    document.css("div.table-list-cell").each { |commit|
      if commit.css("p a.message.js-navigation-open").text != ""
        commit_hash = {
          description: commit.css("p a.message.js-navigation-open").text,
          date: commit.css("relative-time.no-wrap").text
        }
        commit_history << commit_hash
      end
    }
    return commit_history
  end
  
  private
  
  def get_user_info
    user_info = {}
    document = Nokogiri::HTML(open("https://github.com/#{@github_name}"))
    user_info[:name] = document.css("span.p-name.vcard-fullname.d-block.overflow-hidden").text
    user_info[:contributions] = document.css("h2.f4.text-normal.mb-2")[1].text.split(' ')[0]
    return user_info
  end
  
  def get_repositories
    document = Nokogiri::HTML(open("https://github.com/#{@github_name}?tab=repositories"))
    repositories = document.css("div.d-inline-block.mb-1 h3 a")
    repositories.each { |repository|
      repository[:name] = repository.text.split(' ')[0]
      repository[:href] = repository.attr("href")
    }
    return repositories
  end
end
