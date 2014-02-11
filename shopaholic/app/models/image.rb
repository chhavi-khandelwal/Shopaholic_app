class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :file, styles: { :medium => "200x200", :thumb => "150x150" }, default_url: "default.jpg"
  
end
