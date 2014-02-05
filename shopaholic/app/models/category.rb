class Category < ActiveRecord::Base
  has_many :brands, through: :products
  has_many :products, dependent: :restrict_with_exception
  validates :name, presence: true
  validates :name, :format => { :with => /\A(\w+\-?\w+)+|(\w+)\Z/, :message => "- Special characters not allowed" }, unless: "name.blank?"
  validates :name, :uniqueness => { :case_sensitive => false }
end
