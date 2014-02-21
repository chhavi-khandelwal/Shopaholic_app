#FIXME_AB: See brand model for comments
class Size < ActiveRecord::Base
  belongs_to :color, touch: true

  validates :name, :price, :quantity, :discounted_price, :sku, presence: true

  #FIXME_AB: TEXT_REGEXP does not make it clear what it is doing. Also Make a constant has not just a constant like: REGEXP[:name_format]
  #fixed

  validates :name, length: { maximum: 25 }
  validates :name, format: { with: REGEXP[:name_format], multiline: true, message: "- Special characters not allowed" }, unless: "name.blank?"

  validates :name, uniqueness: { case_sensitive: false, scope: :color_id, message: "Size already exists for this color"  }

  validates :quantity, numericality: { greater_than: 0 }, unless: "quantity.blank?"

  validates :price, numericality: { greater_than: 0 }, unless: "price.blank?"

  validates :discounted_price, numericality: { greater_than: 0, less_than_or_equal_to: :price }, unless: "discounted_price.blank?"

  validates :sku, uniqueness: true

end