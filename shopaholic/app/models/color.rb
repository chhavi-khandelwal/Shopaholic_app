class Color < ActiveRecord::Base
  has_many :sizes
  belongs_to :product
#FIXME_AB: no validations? please add all possible validations in all models
end
