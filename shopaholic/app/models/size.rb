class Size < ActiveRecord::Base
  belongs_to :color

  validates :name, :price, :quantity, :discounted_price, presence: true

  validates :name, :format => { :with => /\A(\w+\-?\w+)+|(\w+)\Z/, :message => "- Special characters not allowed" }, unless: "name.blank?"

  validates :quantity, :numericality => { :greater_than => 0 }, unless: "quantity.blank?"

  validates :price, :numericality => {:greater_than => 0 }, unless: "price.blank?"

  validates :discounted_price, :numericality => { :greater_than => 0, :less_than_or_equal_to => :price }, unless: "discounted_price.blank?"

  
end
