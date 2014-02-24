class Brand < ActiveRecord::Base
  has_many :categories, through: :products
  #FIXME_AB: @brand. destroy will raise exception by :restrict_with_exception. but what about @brand.delete or Brand.delete_all
  include DependencyHelper
  #fixed
  has_many :products, dependent: :restrict_with_exception
  has_one :image, as: :imageable

  validates :name, presence: true, length: { maximum: 255 }
  
  #FIXME_AB: YOu can avoid using prock in unless condition by just writing: unless: brand.name.blank?
  validates :name, format: { with: REGEXP[:name_format], multiline: true, message: "- Only letters allowed" }, uniqueness: { case_sensitive: false }, unless: "name.blank?"
   #FIXED

  #FIXME_AB: No validation for length of the name. What if I save a very long string in name. it would be truncated automatically to 255 chars
  #FIXME_AB: Spaces and hyphen should be allowed in name


end
