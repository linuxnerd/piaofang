class Boxoffice < ActiveRecord::Base
  belongs_to :movie

  scope :max_year_of, lambda { |area| where(area: area).maximum("year") }

  class << self
    def max_week_of(area, year)
      week = 0
      select('wk').where(area: area, year: year).collect do |week_item|
        md = /[\d]+/.match(week_item.wk)
        week = md[0].to_i if md[0].to_i > week
      end
      week
    end

    def latest_boxoffice(area)
      year = max_year_of(area)
      week = max_week_of(area, year)

      where("area=? and year=? and wk like ?",
              area, year, "(第#{week}周)%").order("rid asc")
    end
  end
end
