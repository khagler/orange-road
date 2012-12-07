require 'net/http'
require 'JSON'

module GitHubRepos
  
  # The +github_public_repos+ method returns an unordered list of a user's
  # public repositorys on GitHub.
  # * _user_ = The GitHub username
  def github_public_repos(user)
    uri = URI("https://api.github.com/users/#{user}/repos")
    Net::HTTP.start(uri.host,
                    uri.port,
                    :use_ssl => true) do |http|
      request = Net::HTTP::Get.new uri.request_uri
      @response = http.request request
    end
    @repo_list = "<ul>\n"
    JSON.parse(@response.body,
               {:symbolize_names => true}).each { |e| @repo_list << %(<li>#{e[:full_name]}</li>\n) }
    @repo_list << "</ul>\n"
  end
end