require 'nokogiri'
require 'httparty'
require 'byebug'


def parse_content content

end

def doding_scraper

  url = "https://dodinghaleluya.wordpress.com/doding-haleluya/puji-pujian/hal-1-jahowa-sihol-pujionku/"

  status = true

  while status == true

    # get raw html from url
    raw_page = HTTParty.get(url)

    # parse raw html to nokogiri format
    parsed_page = Nokogiri::HTML(raw_page)

    # get the main content page
    content = parsed_page.css('div.entry-content')

    # call parse function to parse the content
    # by sending content as parameter
    parse_content content

    # fetch all available link from content
    links = content.css('td a').last

    # get the last link (button next is the last one)
    # on the main content
    next_link = links.values.last

    if next_link == nil
      # if nil, status false the scraping process is done
      status = false
    else
      # if not nil, set url with new fecthed link from page
      url = next_link
      puts next_link
    end
    #byebug
  end
end

doding_scraper
