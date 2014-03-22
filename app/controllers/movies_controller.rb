class MoviesController < ApplicationController
  before_action :admin_user, only: [:index, :edit, :update]
  def index
    # source: m1905
    @us = Boxoffice.latest_boxoffice('北美票房')
    @hk = Boxoffice.latest_boxoffice('香港票房')
    @cn = Boxoffice.latest_boxoffice('内地票房')
    @jp = Boxoffice.latest_boxoffice('日本票房')
    

    # source: mtime
    @tw = Boxoffice.where(area: '台湾票房榜', source: 'mtime').order('wk desc, rid asc').limit(10)
    @kr = Boxoffice.where(area: '韩国票房榜', source: 'mtime').order('wk desc, rid asc').limit(10)
    @fr = Boxoffice.where(area: '法国票房榜', source: 'mtime').order('wk desc, rid asc').limit(10)
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movies_path, :flash => { :success=>"资料编辑完成" }
    else
      render 'edit'
    end
  end

  private
    def movie_params
      params.require(:movie).permit(:torrent_url, :torrent_type, :has_subtitle)
    end

end
