class Color < ActiveRecord::Base
  has_many :sizes
  belongs_to :product

end
