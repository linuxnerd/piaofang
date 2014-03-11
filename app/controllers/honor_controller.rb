class HonorController < ApplicationController
  def search
    unless params['movie_name'].blank?
      @boxoffice_movies_list = Movie.where("name like ? or en_name like ?",
          "%#{params['movie_name']}%", "%#{params['movie_name']}%")

      @honor_movies_list = Honor.select(:name).distinct.where("name like ?","%#{params['movie_name']}%")


      render 'index'
    end
  end

end
