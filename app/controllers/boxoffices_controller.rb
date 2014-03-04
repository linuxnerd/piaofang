class BoxofficesController < ApplicationController
  def index
    @us = Boxoffice.where(area: 'US').order('rid asc')
    @hk = Boxoffice.where(area: 'HK').order('rid asc')
    @cn = Boxoffice.where(area: 'CN').order('rid asc')
  end
end
