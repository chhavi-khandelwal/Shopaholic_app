class Product < ActiveRecord::Base
  has_many :sizes, through: :colors
  has_many :colors
  belongs_to :category
  belongs_to :brand

  validates :title, presence: true
  # validates :title, format: { with: REGEXP[:name_format], message: "- Special characters not allowed" }, unless: Proc.new { |product| product.title.blank? }
  validates :title, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  
end
