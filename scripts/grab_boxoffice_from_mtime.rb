require "open-uri"
require "nokogiri"

BASE_URL = "http://movie.mtime.com/boxoffice"

html_stream = open(BASE_URL)
page = Nokogiri::HTML(html_stream)

page.css('div.ticket_list').collect do |area_item|

  # 这四类票房榜取m1905
  case area_item['name']
  when '北美票房榜', '内地票房榜', '香港票房榜', '日本票房榜'
    next
  end

  area_item.css('ul.content li').collect do |row|
    # prepare row data
    rid = row.css('em.c_green').text # 排名
    year = row.css('em.c_666').text # 年份
    area = area_item['name'] # 区域
    wk = area_item['date'] # 周数
    wboxoffice = row.css('span.weekly').text # 周票房
    tboxoffice = row.css('span.sum').text # 总票房

    # grab img_url, director, actor_list from detail page
    begin
      detail_url = row.css('a').attr('href').text
      detail_stream = open(detail_url)
      detail_page = Nokogiri::HTML(detail_stream)

      # movie rating
      # rating = detail_page.css("span[property='v:average']").text

      # director
      director = detail_page.css("a[rel='v:directedBy']").text

      # actors & actress list
      actors = detail_page.css("dl.main_actor").collect do |actor|
        actor.css("a[rel='v:starring']").first.text
      end.join(', ')

      # movie type
      types = detail_page.css("div.otherbox").text.split(' - ').second

      # release date
      release_date = detail_page.css("a[property='v:initialReleaseDate']").text.strip

      # summary
      summary = detail_page.css("p.lh18").text.strip

      # movie_name
      name = detail_page.css("h1[property='v:itemreviewed']").text.strip
      en_name = detail_page.css("p.db_enname").text.strip

      # 海报缩略图链接（海报可能没有）
      unless detail_page.css("img[rel='v:image']").blank?
        poster_url = detail_page.css("img[rel='v:image']").attr('src').text
        filename = poster_url.split('/').last
        data = open(poster_url) { |f| f.read }
        file_path = "public/uploads/poster/#{name}/#{filename}"
        url_path = "/uploads/poster/#{name}/#{filename}"

        #if folder not exist,then creat it.
        Dir.mkdir("public/uploads/poster/#{name}") unless File.exist?("public/uploads/poster/#{name}")
        open(file_path,"wb") { |f| f.write(data) } unless File.exist?(file_path)
      end

      # import into database
      movie = Movie.where(name: name).first
      if movie.nil?
        movie = Movie.create!(name: name,
                        en_name: en_name,
                        poster_url: url_path,
                        #rating: rating,
                        director: director,
                        actors: actors,
                        types: types,
                        release_date: release_date,
                        summary: summary)
      end

      if Boxoffice.where(wk: wk, area: area, movie_id: movie.id).first.nil?
        movie.boxoffices.create!(rid: rid,
                          year: year,
                          area: area,
                          wk: wk,
                          source: 'mtime',
                          wboxoffice: wboxoffice,
                          tboxoffice: tboxoffice)
      end

      p '【'+Time.current.strftime("%Y-%m-%d %H:%M:%S")+'】'+area+'_'+name+' [ok]'

    #rescue Exception
      #p area+'_'+name+'('+detail_url+')打开失败'
    end

  end

end
