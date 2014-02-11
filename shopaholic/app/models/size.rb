class Size < ActiveRecord::Base
  belongs_to :color

  validates :name, :price, :quantity, :discounted_price, presence: true

  #FIXME_AB: To keep all regexp at one place and resuse them, it is a good idea to make a constant hash in initializers and user that hash here.
  validates :name, format: { with: Shopaholic::Application.config.TEXT_REGEXP, message: "- Special characters not allowed" }, unless: "name.blank?"
  #fixed

  #FIXME_AB: Any specific reason you are using string in unless statement
  validates :quantity, numericality: { greater_than: 0 }, unless: "quantity.blank?"

  #FIXME_AB: Try to use new has syntax key: value
  validates :price, numericality: { greater_than: 0 }, unless: "price.blank?"
  #FIXED

  validates :discounted_price, numericality: { greater_than: 0, less_than_or_equal_to: :price }, unless: "discounted_price.blank?"

end
