class Brand < ActiveRecord::Base
  has_many :categories, through: :products
  has_many :products, dependent: :restrict_with_exception
  has_one :image, as: :imageable

  validates :name, presence: true
  validates :name, format: { with: Shopaholic::Application.config.TEXT_REGEXP, message: "- Only letters allowed" }, uniqueness: { case_sensitive: false }, unless: Proc.new { |brand| brand.name.blank? }


end
