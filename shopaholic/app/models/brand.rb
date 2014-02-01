class Brand < ActiveRecord::Base
  has_many :categories, through: :products
  has_many :products
  validates :name, :format => { :with => /\A(\w+\-?\w+)+|(\w+)\Z/, :message => "- Only letters allowed" }, :uniqueness => { :case_sensitive => false }, presence: true

#FIXME_AB: Can a brand and categories be deleted?
end
