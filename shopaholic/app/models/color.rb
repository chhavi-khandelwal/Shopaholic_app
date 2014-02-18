class Color < ActiveRecord::Base
  has_many :sizes, dependent: :restrict_with_exception
  has_many :images, as: :imageable, dependent: :destroy
  belongs_to :product

  validates :name, presence: true, length: { maximum: 255 }
  validates :name, format: { with: REGEXP[:name_format], multiline: true, message: "- Special characters not allowed" }, unless: "name.blank?"
  validates :name, uniqueness: { case_sensitive: false, scope: :product_id, message: "Color already exists"  }

  accepts_nested_attributes_for :images, update_only: true, allow_destroy: true

end
