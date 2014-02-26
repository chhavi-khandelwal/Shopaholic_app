class LineItem < ActiveRecord::Base
  belongs_to :size, dependent: :destroy
  belongs_to :cart, dependent: :destroy
end
