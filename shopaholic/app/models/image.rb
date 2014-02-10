class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :display_pic, :styles => { :medium => "200x200", :thumb => "150x150" }, :default_url => "default.jpg"
  
  # validates_attachment_content_type :display_pic, :content_type => /\Aimage\/.*\Z/
end
