require "open-uri"
require "nokogiri"

BASE_URL = 'http://www.m1905.com/rank/top'



###################################
# 以下为拼数据函数
###################################

# 从BASE_URL获取票房榜的具体URL地址
def boxoffices_page
  html_stream = open(BASE_URL)
  page = Nokogiri::HTML(html_stream)

  list = []
  page.css('#Menu_list_4 a').collect do |item|
    list << { :area => item.text, :url => item['href'] }
  end
  list
end

# 从票房榜的具体URL地址中获取年份的URL
def year_list_in(boxoffice_url)
  html_stream = open(boxoffice_url)
  page = Nokogiri::HTML(html_stream)

  list = []
  page.css('div.sel_botbox').first.css('div.sel_xzline a').collect do |item|
    list << { :year => item.text, :url => item['href'] }
  end
  list
end

# 从年份URL中获取周URL（最终票房榜数据的URL）
def week_list_in(year_url)
  html_stream = open(year_url)
  page = Nokogiri::HTML(html_stream)
  list = []
  page.css('div.sel_botbox')[1].css('div.sel_xzline a').collect do |item|
    list << { :week => item.text, :url => item['href'] }
  end
  list
end

# 获得每周票房榜汇总数据
def boxoffice_list
  list = []
  boxoffices_page.collect do |page_item|
    area = page_item[:area]
    year_list_in(page_item[:url]).collect do |year_item|
      year = year_item[:year]
      week_list_in(year_item[:url]).collect do |week_item|
        list << {:area=>area, :year=>year, :week=>week_item[:week], :url=>week_item[:url]}
      end # week_list
    end # year_list
  end # page_list
  list
end # def boxoffice_list



###########################
# 程序入口
###########################
def main
  boxoffice_list.collect do |boxoffice_item|
    html_stream = open(boxoffice_item[:url])
    page = Nokogiri::HTML(html_stream)

    page.css('tr.tableCONT').collect do |row|
      rid = row.css('td.blueQsCD').text # 名词
      area = boxoffice_item[:area] # 地区
      year = boxoffice_item[:year] # 年份
      week = boxoffice_item[:week] # 周数
      
      begin
        detail_url = row.css('span.pl08 a')[0]['href'] # 明细页面链接
        detail_page = Nokogiri::HTML(open(detail_url))

        next if detail_page.css('div.laMovName h1 a').text.blank? # 无影片详细页面

        name = detail_page.css('div.laMovName h1 a').text # 影片中文名
        en_name = detail_page.css('div.laMovName div.fl a')[0].text.strip # 影片英文名
        director = detail_page.css('ol.movStaff li')[0].css('a').text # 导演
        rating = detail_page.css('.rating-dt span.score').text # 评分

        # 演员表
        actors = detail_page.css('ol.movStaff li')[1].css('a.laBlueS_f').collect do |actor|
          actor.text.strip
        end.join(', ')
        
        # 影片类型
        types = detail_page.css('ol.movStaff li')[2].css('a').collect do |type|
          type.text.strip
        end.join('/')

        # 上映日期
        if detail_page.css('ol.movStaff li')[4]
          r_year = detail_page.css('ol.movStaff li')[4].css('a')[0].text
          r_date = detail_page.css('ol.movStaff li')[4].css('a')[1].text.strip
          release_date = r_year + '年' + r_date
        end

        # 剧情页面获取全部剧情
        scenario_page = Nokogiri::HTML(open(detail_url+'scenario/'))
        summary = scenario_page.css('.line_Slx').text.gsub(%r{\r\n}, "")
        p summary
        p area+year+week+name

      rescue Exception
        p detail_url+'打开失败'
      end

    end
  end

end

main