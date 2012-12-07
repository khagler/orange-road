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
    @repo_list = "<dl>\n"
    JSON.parse(@response.body, {:symbolize_names => true}).each do |e|
      @repo_list << %(<dt>#{e[:full_name]} #{'(Fork)' if e[:fork]}</dt>\n)
      @repo_list << %(<dd>#{e[:description]}</dd>\n)
    end
    @repo_list << "</dl>\n"
  end
end