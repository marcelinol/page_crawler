require "capybara/dsl"
require "capybara"

Capybara.run_server = false
Capybara.current_driver = :selenium_headless

class Crawler
  include Capybara::DSL

  def initialize(url, element)
    Capybara.app_host = url
    @element = element
  end

  def run
    content = read_page_body
    puts content

    post_to_requestbin(content)
  end

  private

  def read_page_body
    visit("/")

    find(@element).text
  end

  require "net/http"
  require "uri"
  # Temporary method until this app is integrated with aws EventBridge
  def post_to_requestbin(content)
    uri = URI("https://enil4xfkzcdpp.x.pipedream.net/") # RequestBin https://requestbin.com/r/enil4xfkzcdpp
    Net::HTTP.post(
      URI(uri),
      { oinp_content: content }.to_json,
      "Content-Type" => "application/json"
    )
  end
end

Crawler.new("https://www.ontario.ca/page/2020-ontario-immigrant-nominee-program-updates", "#pagebody").run