class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :sizes, through: :line_items
end
