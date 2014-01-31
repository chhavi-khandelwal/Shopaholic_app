class Category < ActiveRecord::Base
  has_many :brands, through: :products
  has_many :products
  validates :name, :format => { :with => /\A(\w+\-?\w+)+|(\w+)\Z/, :message => "- Only letters allowed" }, :uniqueness => { :case_sensitive => false }, presence: true
end
