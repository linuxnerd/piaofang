require "open-uri"
require "json"
require "nokogiri"

BASE_URL = "http://movie.mtime.com/boxoffice"


html_stream = open(BASE_URL)
page = Nokogiri::HTML(html_stream)

page.css('div.ticket_list').collect do |area_item|

  area_item.css('ul.content li').collect do |row|
    # prepare row data
    rid = row.css('em.c_green').text # 排名
    name = row.css('a').text.strip # 名称
    year = row.css('em.c_666').text # 年份
    area = area_item['name'] # 区域
    wk = area_item['date'] # 周数
    wboxoffice = row.css('span.weekly').text # 周票房
    tboxoffice = row.css('span.sum').text # 总票房

    p rid
    p name
    p year
    p area
    p wk
    p wboxoffice
    p tboxoffice

    # grab img_url, director, actor_list from detail page
    detail_url = row.css('a').attr('href').text
    detail_stream = open(detail_url)
    detail_page = Nokogiri::HTML(detail_stream)

    image_url = detail_page.css('img.movie_film_img').attr('src').text
    p image_url

  end

end
