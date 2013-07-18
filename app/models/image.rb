class Image < ActiveRecord::Base
  # caption
  # image_type
  attr_accessible :caption, :image_type, :name
  
  mount_uploader :info, ImageUploader
end
