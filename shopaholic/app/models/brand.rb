class Brand < ActiveRecord::Base
  has_many :categories, through: :products
  has_many :products, dependent: :restrict_with_exception
  has_one :image, as: :imageable

  validates :name, presence: true
  validates :name, :format => { :with => /\A(\w+\-?\w+)+\Z/, :message => "- Only letters allowed" }, :uniqueness => { :case_sensitive => false }, unless: "name.blank?"

end
