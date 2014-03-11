class HonorController < ApplicationController
  def search
    unless params['movie_name'].blank?
      movie_list = Movie.where("name like ? or en_name like ?",
          "%#{params['movie_name']}%", "%#{params['movie_name']}%")
      if movie_list
        @bhonor_list = []
        movie_list.collect do |movie|
          # 根据名称去票房榜中查找列表
          movie.boxoffices.collect do |b|
            @bhonor_list << { :rid => b.rid, :name => movie.name,
                              :wk => b.wk, :area => b.area }
          end
        end

        # 按照票房榜排名排序
        @bhonor_list.sort_by!{ |b| b[:rid] }
        p @bhonor_list
      end
      render 'index'
    end
  end

end
