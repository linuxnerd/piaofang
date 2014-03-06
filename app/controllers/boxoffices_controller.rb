class BoxofficesController < ApplicationController
  def index
    @us = Boxoffice.where(area: '北美票房榜').order('rid asc')
    @hk = Boxoffice.where(area: '香港票房榜').order('rid asc')
    @cn = Boxoffice.where(area: '内地票房榜').order('rid asc')
    @tw = Boxoffice.where(area: '台湾票房榜').order('rid asc')
    @kr = Boxoffice.where(area: '韩国票房榜').order('rid asc')
    @jp = Boxoffice.where(area: '日本票房榜').order('rid asc')
    @fr = Boxoffice.where(area: '法国票房榜').order('rid asc')
  end
end
