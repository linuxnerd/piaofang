require "open-uri"
require "json"
require "nokogiri"

BASE_URL = "http://movie.mtime.com/boxoffice"


html_stream = open(BASE_URL)
page = Nokogiri::HTML(html_stream)

Boxoffice.delete_all

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

    # grab img_url, director, actor_list from detail page
    detail_url = row.css('a').attr('href').text
    detail_stream = open(detail_url)
    detail_page = Nokogiri::HTML(detail_stream)

    # movie rating
    rating = detail_page.css("span[property='v:average']").text

    # director
    director = detail_page.css("a[rel='v:directedBy']").text

    # actors & actress list
    actors = detail_page.css("li a[rel='v:starring']").collect do |actor|
      actor.text
    end.join(', ')

    # movie type
    types = detail_page.css("li a[property='v:genre']").collect do |type|
      type.text.strip
    end.join('/')

    # release date
    release_date = detail_page.css("li span[property='v:initialReleaseDate']").text.strip

    # 海报缩略图链接
    image_url = detail_page.css('img.movie_film_img').attr('src').text 
    filename = image_url.split('/').last
    data = open(image_url) { |f| f.read }
    file_path = "public/uploads/poster/#{name}/#{filename}"
    url_path = "/uploads/poster/#{name}/#{filename}"

    #if folder not exist,then creat it.
    Dir.mkdir("public/uploads/poster/#{name}") unless File.exist?("public/uploads/poster/#{name}")
    open(file_path,"wb") { |f| f.write(data) } unless File.exist?(file_path)

    # import into database
    Boxoffice.create!(rid: rid,
                      name: name,
                      year: year,
                      area: area,
                      wk: wk,
                      wboxoffice: wboxoffice,
                      tboxoffice: tboxoffice,
                      image_url: url_path,
                      rating: rating,
                      director: director,
                      actors: actors,
                      types: types,
                      release_date: release_date)
  end

end
