require "open-uri"
require "nokogiri"

BASE_URL ='http://www.1905.com/mdb/film/festival/page/?festivalid=3'

def oscar_list
  html_stream = open(BASE_URL)
  page = Nokogiri::HTML(html_stream)
  
  # 获取
  page.css('.item dd')[1].css('a').collect do |item|
    { :year => item.text, :url => item['href'] }
  end
end

def main
  Honor.delete_all

  oscar_list.collect do |oscar_item|
    begin
      page = Nokogiri::HTML(open("http://www.1905.com"+oscar_item[:url]))
      
      year = oscar_item[:year] # 年份
      session = page.css('.mdb-awards-intro p.t-CH').text
      
      page.css('.con-bd').collect do |row|
        award_name = row.css('li.left a').text

        # 影片奖项才做处理
        case award_name
        when
          # 首选奖项
          '最佳改编剧本', '最佳影片', '最佳原创剧本',
          '最佳动画长片', '最佳外语片', '最佳纪录长片',
          # 次要奖项
          '最佳音响效果', '最佳音效剪辑', '最佳视觉效果',
          '最佳原创歌曲', '最佳摄影', '最佳原创音乐',
          '最佳服装设计', '最佳电影剪辑', '最佳化妆与发行'


          winner = row.css('li.center p.info-t a').text
          Honor.create!(session: session,
                        year: year,
                        award_name: award_name,
                        award_type: '获奖',
                        name: winner,
                        festival: 'oscar')
          p '【'+Time.current.strftime("%Y-%m-%d %H:%M:%S")+'】'+year+award_name+'获奖'+winner+' [ok]'

          row.css('li.right span a').collect do |nominate_item|
            Honor.create!(session: session,
                        year: year,
                        award_name: award_name,
                        award_type: '提名',
                        name: nominate_item.text,
                        festival: 'oscar')
            p '【'+Time.current.strftime("%Y-%m-%d %H:%M:%S")+'】'+year+award_name+'提名'+nominate_item.text+' [ok]'
          end
        end

      end
    rescue Exception
      p oscar_item[:url]+'打开失败'
    end
  end
end
main
