class Movie < ActiveRecord::Base
  has_many :boxoffices, dependent: :destroy
end
