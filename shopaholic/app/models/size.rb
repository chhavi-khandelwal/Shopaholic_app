#FIXME_AB: See brand model for comments
class Size < ActiveRecord::Base
  belongs_to :color

  validates :name, :price, :quantity, :discounted_price, :sku, presence: true

  #FIXME_AB: TEXT_REGEXP does not make it clear what it is doing. Also Make a constant has not just a constant like: REGEXP[:name_format]
  validates :name, format: { with: REGEXP[:name_format], message: "- Special characters not allowed" }, unless: Proc.new { |size| size.name.blank? }

  validates :quantity, numericality: { greater_than: 0 }, unless: Proc.new { |size| size.quantity.blank? }

  validates :price, numericality: { greater_than: 0 }, unless: Proc.new { |size| size.price.blank? }

  validates :discounted_price, numericality: { greater_than: 0, less_than_or_equal_to: :price }, unless: Proc.new { |size| size.discounted_price.blank? }

end