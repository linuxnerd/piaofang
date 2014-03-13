class Boxoffice < ActiveRecord::Base
  belongs_to :movie

  def Boxoffice.latest_boxoffice(area)
    year = max_year_of(area)
    week = max_week_of(area, year)

    Boxoffice.where("area=? and year=? and wk like ?",
                    area, year, "(第#{week}周)%").order("rid asc")
  end


  private
    def self.max_year_of(area)
      year_string = Boxoffice.where(area: area).maximum("year")
    end

    def self.max_week_of(area, year)
      week = 0
      self.select('wk').where(area: area, year: year).collect do |week_item|
        md = /[\d]+/.match(week_item.wk)
        week = md[0].to_i if md[0].to_i > week
      end
      week
    end

end
