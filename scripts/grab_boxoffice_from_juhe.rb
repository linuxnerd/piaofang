require "open-uri"
require "json"

BASE_URL = "http://v.juhe.cn/boxoffice/rank?key=#{Settings.movie_api_key}"
AREA_LIST = ['US', 'HK', 'CN']

Boxoffice.delete_all

AREA_LIST.each do |area_list_item|
  url = BASE_URL + '&area=' + area_list_item
  p url
  json_stream = open(url)
  hash = JSON.parse(json_stream.read)

  if hash['resultcode'] == '200'
    hash['result'].each do |r|
      p r
      Boxoffice.create!(area: area_list_item,
                        rid: r['rid'],
                        name: r['name'],
                        wk: r['wk'],
                        wboxoffice: r['wboxoffice'],
                        tboxoffice: r['tboxoffice'])
    end
  end
end