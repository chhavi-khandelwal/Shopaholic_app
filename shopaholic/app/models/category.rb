class Category < ActiveRecord::Base
  has_many :brands, through: :products
  has_many :products, dependent: :restrict_with_exception
  validates :name, presence: true
  validates :name, format: { with: TEXT_REGEXP, message: "- Special characters not allowed" }, unless: Proc.new { |category| category.name.blank? }
  validates :name, uniqueness: { case_sensitive: false }
end
