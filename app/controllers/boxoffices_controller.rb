class BoxofficesController < ApplicationController
  def index
    @us = Boxoffice.where(area: '北美票房榜').order('wk desc, rid asc').limit(10)
    @hk = Boxoffice.where(area: '香港票房榜').order('wk desc, rid asc').limit(10)
    @cn = Boxoffice.where(area: '内地票房榜').order('wk desc, rid asc').limit(10)
    @tw = Boxoffice.where(area: '台湾票房榜').order('wk desc, rid asc').limit(10)
    @kr = Boxoffice.where(area: '韩国票房榜').order('wk desc, rid asc').limit(10)
    @jp = Boxoffice.where(area: '日本票房榜').order('wk desc, rid asc').limit(10)
    @fr = Boxoffice.where(area: '法国票房榜').order('wk desc, rid asc').limit(10)
  end
end
