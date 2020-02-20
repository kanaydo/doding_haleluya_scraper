require 'nokogiri'
require 'httparty'
require 'byebug'


def parse_content parsed_page

  # get the title of doding
  title = parsed_page.css('h1.entry-title').children.text

  # fetch parse the main content
  main = parsed_page.css('div.entry-content')

  # fetch the song from table
  songs = main.css('td p')
  song_list = Array.new
  songs.each_with_index do |song, index|
    song_list << song.children.text
  end
  
  doding = {
    'title': title,
    'songs': song_list
  }
  puts doding
  # byebug
end

def doding_scraper

  url = "https://dodinghaleluya.wordpress.com/doding-haleluya/puji-pujian/hal-1-jahowa-sihol-pujionku/"

  status = true

  counter = 1

  while status == true

    # get raw html from url
    raw_page = HTTParty.get(url)

    # parse raw html to nokogiri format
    parsed_page = Nokogiri::HTML(raw_page)

    # get the main content page
    content = parsed_page.css('div.entry-content')

    # call parse function to parse the content
    # by sending content as parameter
    parse_content parsed_page

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

    # treshold
    if counter == 10
      status = false
    end
    counter += 1
  end
end

doding_scraper
