class Color < ActiveRecord::Base
  has_many :sizes, dependent: :restrict_with_exception
  has_many :images, as: :imageable
  belongs_to :product

  validates :name, presence: true
  validates :name, :format => { :with => /\A(\w+\-?\w+)+|(\w+)\Z/, :message => "- Special characters not allowed" }, unless: "name.blank?"
  validates :name, :uniqueness => { :case_sensitive => false, scope: :product_id, message: "Color with #{ name } already exists"  }

  accepts_nested_attributes_for :images

end
