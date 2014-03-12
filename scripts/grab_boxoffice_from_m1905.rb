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

    page.css('tr.tableCONT td').collect do |row|
      p row
    end

  end
end

main