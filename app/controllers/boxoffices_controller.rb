class BoxofficesController < ApplicationController
  def index
    @us = Boxoffice.where(area: '北美票房榜').order('rid asc')
    @hk = Boxoffice.where(area: '香港票房榜').order('rid asc')
    @cn = Boxoffice.where(area: '内地票房榜').order('rid asc')
  end
end
