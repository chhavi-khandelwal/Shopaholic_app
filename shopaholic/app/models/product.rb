class Product < ActiveRecord::Base
  has_many :sizes, through: :colors
  has_many :colors
  belongs_to :category
  belongs_to :brand
  validates :title, :format => { :with => /\A(\w+\-?\w+)+|(\w+)\Z/, :message => "- Only letters allowed" }, :uniqueness => { :case_sensitive => false }, presence: true
  
  scope :by_category, ->(id) { where category_id: id }
  scope :by_product, ->(id) { where product_id: id }
  
end
