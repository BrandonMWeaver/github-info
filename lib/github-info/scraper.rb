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
    repositories = document.css("div.d-inline-block.mb-1 h3 a").collect { |repository|
      repository.text.split(' ')[0]
    }
    return repositories
  end
end
