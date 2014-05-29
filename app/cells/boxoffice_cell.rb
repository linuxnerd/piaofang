class BoxofficeCell < Cell::Rails
  cache :m1905_boxoffice, expires_in: 1.day do |options|
    options[:area]
  end

  cache :mtime_boxoffice, expires_in: 3.days do |options|
    options[:area]
  end

  helper BoxofficesHelper

  def m1905_boxoffice(args)
    @area = args[:area]
    @m1905_latest_boxoffice = Boxoffice.latest_boxoffice(@area)
    render
  end

  def mtime_boxoffice(args)
    @area = args[:area]
    @mtime_latest_boxoffice = Boxoffice.where(area: @area).order('wk desc, rid asc').limit(10)
    render
  end

end
