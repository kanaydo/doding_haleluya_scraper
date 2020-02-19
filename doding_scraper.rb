require 'nokogiri'
require 'httparty'
require 'byebug'

def doding_scraper

  url = "https://dodinghaleluya.wordpress.com/doding-haleluya/puji-pujian/hal-1-jahowa-sihol-pujionku/"

  status = true

  while status == true
    raw_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(raw_page)
    content = parsed_page.css('div.entry-content')
    links = content.css('td a').last
    next_link = links.values.last
    if next_link == nil
      status = false
    else
      url = next_link
      puts next_link
    end
    #byebug
  end
end

doding_scraper
