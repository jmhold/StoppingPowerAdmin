class Image < ActiveRecord::Base
  # caption
  # type
  attr_accessible :caption, :image_type, :name
  
  mount_uploader :info, ImageUploader
end
