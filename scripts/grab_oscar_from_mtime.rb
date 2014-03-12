require "open-uri"
require "nokogiri"

BASE_URL = 'http://award.mtime.com/3/'

def oscar_list
  html_stream = open(BASE_URL)
  page = Nokogiri::HTML(html_stream)

  list = []
  page.css('.event_yearlist a').collect do |year|
    next if year.text <= '1971' # 1971年之前的页面问题较多，由于时间久远暂时忽略
    list << year['href']
  end
  list
end



Honor.delete_all

oscar_list.collect do |url|
  begin
    oscar_stream_of_year = open(url)
    oscar_page_of_year = Nokogiri::HTML(oscar_stream_of_year)

    session = oscar_page_of_year.css('.img_box_gray').first['alt'] # 第几届

    year = oscar_page_of_year.css('title').text.split.last # 年份

    i = 0
    # 以下奖项为影片奖项（非人物获得）
    oscar_page_of_year.css("a[level='2']").collect do |award|
      award_name = award['data'].split('B').first # 奖项名
      case award_name
      when  # 主要奖项
            '最佳影片','最佳原创剧本','最佳改编剧本','最佳动画长片','最佳外语片',
            # 次要奖项
            '最佳摄影','最佳艺术指导','最佳服装设计',
            '最佳音响效果','最佳电影剪辑','最佳音效剪辑',
            '最佳视觉效果','最佳化妆与发型','最佳原创歌曲',
            '最佳原创配乐',
            # 以下为年代久远的奖项
            '最佳配乐（原创）','最佳声效','最佳音响',
            '最佳服装设计（彩色）','最佳服装设计（黑白）','最佳艺术指导（黑白）',
            '最佳艺术指导（彩色）','最佳摄影（黑白）','最佳摄影（彩色）',
            '最佳改编配乐'

        
        # 获奖影片名
        winner = oscar_page_of_year.css('div.yellowbox div.review_list strong.c_a5 a')[i].text
        Honor.create!(session: session,
                      year: year,
                      award_name: award_name,
                      award_type: '获奖',
                      name: winner,
                      festival: 'oscar')
        p year+award_name+'获奖'+winner+' [ok]'

        # 提名影片
        oscar_page_of_year.css('div.bluebox div.review_list')[i].css('strong a').collect do |nominate_item|
          Honor.create!(session: session,
                      year: year,
                      award_name: award_name,
                      award_type: '提名',
                      name: nominate_item.text,
                      festival: 'oscar')
          p year+award_name+'提名'+nominate_item.text+' [ok]'
        end
      end

      i += 1
    end
    

  rescue Exception
    p url + '打开失败'
  end

end