class BoxofficeCell < Cell::Rails
  cache :m1905_boxoffice, expires_in: 30.minutes do |options|
    options[:area]
  end

  cache :mtime_boxoffice, expires_in: 30.minutes do |options|
    options[:area]
  end

  helper BoxofficesHelper

  def m1905_boxoffice(args)
    @m1905_latest_boxoffice = Boxoffice.latest_m1905_boxoffice_of(args[:area])
    render
  end

  def mtime_boxoffice(args)
    @mtime_latest_boxoffice = Boxoffice.latest_mtime_boxoffice_of(args[:area])
    render
  end

end
