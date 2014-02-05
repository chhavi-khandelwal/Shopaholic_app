class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :display_pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  
  # validates_attachment_content_type :display_pic, :content_type => /\Aimage\/.*\Z/
end
