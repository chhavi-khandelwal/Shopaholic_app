class Product < ActiveRecord::Base
  belongs_to :category
  validates :title, presence: true
  scope :by_category, ->(id) { where category_id: id }
end
