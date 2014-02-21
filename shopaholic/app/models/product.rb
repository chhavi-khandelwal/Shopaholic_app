class Product < ActiveRecord::Base
  #FIXME_AB: When product is created its published status is NULL in db, why?
  has_many :sizes, through: :colors
  has_many :colors
  belongs_to :category
  belongs_to :brand
  before_save :set_published

  scope :published, -> { where published: true }

  validates :title, presence: true, length: { maximum: 255 }
  validates :title, format: { with: REGEXP[:name_format], multiline: true, message: "- Special characters not allowed" }, unless: "title.blank?"
  validates :title, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 1000 }

  private
  def set_published
    if sizes.exists?
      self.published = true
    end
  end
end
