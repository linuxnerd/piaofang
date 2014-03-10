require "open-uri"
require "nokogiri"

BASE_URL = 'http://award.mtime.com/3/'

def oscar_list
  html_stream = open(BASE_URL)
  page = Nokogiri::HTML(html_stream)

  list = []
  page.css('.event_yearlist a').collect do |year|
    list << year['href']
  end
  list
end

oscar_list.collect do |url|
  begin
    oscar_stream_of_year = open(url)
    oscar_page_of_year = Nokogiri::HTML(oscar_stream_of_year)

    p oscar_page_of_year.css('img_box_gray').text

  rescue Exception
  end

end