require "open-uri"
require "json"
require "nokogiri"

BASE_URL = "http://movie.mtime.com/boxoffice"

def area_list
  [
    ['US', '北美票房榜'],
    ['HK', '香港票房榜'],
    ['CN', '内地票房榜'],
    ['TW', '台湾票房榜'],
    ['JP', '日本票房榜'],
    ['KR', '韩国票房榜'],
    ['FR', '法国票房榜']
  ]
end

html_stream = open(BASE_URL)
page = Nokogiri::HTML(html_stream)

page.css("div.ticket_list").collect do |boxoffice_item|
  p 1
end
