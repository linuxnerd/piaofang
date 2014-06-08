class Boxoffice < ActiveRecord::Base
  belongs_to :movie

  scope :max_year_of, lambda { |area| where(area: area).maximum("year") }

  class << self
    def max_m1905_week_of(area, year)
      week = 0
      select('DISTINCT wk').where(area: area, year: year).collect do |week_item|
        md = /[\d]+/.match(week_item.wk)
        week = md[0].to_i if md[0].to_i > week
      end
      week
    end

    def max_mtime_week_of(area)
      date = Date.new(2000,1,1)
      select('DISTINCT wk').where(area: area).collect do |week_item|
        if area == "台湾票房榜"
          week_start_date = week_item.wk.split(' ').first
        else
          week_start_date = week_item.wk.split('-').first
        end

        if week_start_date =~ /\A[\d]+.[\d]+.[\d]+/
          date = week_start_date.to_date if week_start_date.to_date > date
        end
      end
      date.strftime("%Y.%-m.%-d")
    end

    def latest_m1905_boxoffice_of(area)
      year = max_year_of(area)
      week = max_m1905_week_of(area, year)

      where("area=? and year=? and wk like ?",
              area, year, "(第#{week}周)%").order("rid asc")
    end

    def latest_mtime_boxoffice_of(area)
      week = max_mtime_week_of(area)

      where("area=? and wk like ?", area, "#{week}%").order("rid asc")
    end

  end
end
