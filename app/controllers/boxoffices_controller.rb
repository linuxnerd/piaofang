class BoxofficesController < ApplicationController
  def index
    @us = Boxoffice.where(area: 'US')
    @hk = Boxoffice.where(area: 'HK')
    @cn = Boxoffice.where(area: 'CN')
  end
end
