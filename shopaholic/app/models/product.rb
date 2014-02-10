class Product < ActiveRecord::Base
  has_many :sizes, through: :colors
  has_many :colors
  belongs_to :category
  belongs_to :brand
  validates :title, :format => { :with => /\A(\w+\-?\w+)+\Z/, :message => "- Special characters not allowed" }, unless: "title.blank?"
  validates :title, :uniqueness => { :case_sensitive => false }
  
end
