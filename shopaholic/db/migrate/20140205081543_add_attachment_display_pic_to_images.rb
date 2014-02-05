class AddAttachmentDisplayPicToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :display_pic
    end
  end

  def self.down
    drop_attached_file :images, :display_pic
  end
end
