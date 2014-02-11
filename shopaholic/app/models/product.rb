class Product < ActiveRecord::Base
  has_many :sizes, through: :colors
  has_many :colors
  belongs_to :category
  belongs_to :brand

  validates :title, presence: true
  validates :title, format: { with: Shopaholic::Application.config.TEXT_REGEXP, message: "- Special characters not allowed" }, unless: "title.blank?"
  validates :title, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  
end
