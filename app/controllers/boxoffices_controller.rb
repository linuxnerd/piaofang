class BoxofficesController < ApplicationController
  def index
    # source: m1905
    @us = Boxoffice.where(area: '北美票房').order('wk desc, rid asc').limit(10)
    @hk = Boxoffice.where(area: '香港票房').order('wk desc, rid asc').limit(10)
    @cn = Boxoffice.latest_boxoffice('内地票房')
    @jp = Boxoffice.where(area: '日本票房').order('wk desc, rid asc').limit(10)
    

    # source: mtime
    @tw = Boxoffice.where(area: '台湾票房榜', source: 'mtime').order('wk desc, rid asc').limit(10)
    @kr = Boxoffice.where(area: '韩国票房榜', source: 'mtime').order('wk desc, rid asc').limit(10)
    @fr = Boxoffice.where(area: '法国票房榜', source: 'mtime').order('wk desc, rid asc').limit(10)
    
  end
end
