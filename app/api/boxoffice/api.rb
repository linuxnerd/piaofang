class Boxoffice::API < Grape::API
  #version 'v1', using: :path
  prefix 'api'
  format :json
  default_error_status 400

  params do
    optional :area, type: Symbol, values: [:US, :HK, :CN, :TW, :JP, :KR, :FR], default: :US
  end

  helpers do
    def logger
      Grape::API.logger
    end
  end

  resource :boxoffices do
    desc "Return a boxoffice list"
    get do
      area = case params[:area]
             when :US then '北美票房'
             when :HK then '香港票房'
             when :CN then '内地票房'
             when :JP then '日本票房'
             when :TW then '台湾票房榜'
             when :KR then '韩国票房榜'
             when :FR then '法国票房榜'
             end
      logger.info area
      if %w[北美票房 香港票房 内地票房 日本票房].include?(area)
        boxoffices = Boxoffice.latest_m1905_boxoffice_of(area)
      else
        boxoffices = Boxoffice.latest_mtime_boxoffice_of(area)
      end
      [].tap do |results|
        boxoffices.each do |item|
          results << {
            rid: item.rid, wk: item.wk, wboxoffice: item.wboxoffice,
            wboxoffice: item.wboxoffice, name: item.movie.name, 
            poster_url: item.movie.poster_url, rating: item.movie.rating,
            director: item.movie.director, actors: item.movie.actors,
            types: item.movie.types, release_date: item.movie.release_date,
            summary: item.movie.summary, en_name: item.movie.en_name,
            torrent_url: item.movie.torrent_url, torrent_type: item.movie.torrent_type,
            has_subtitle: item.movie.has_subtitle
          }
        end # each loop
      end # tap
    end # get
  end
end