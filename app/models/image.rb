class Image < ActiveRecord::Base
  # caption
  # image_type
  attr_accessible :caption, :image_type, :name
  
  mount_uploader :info, ImageUploader
  
  def filename
    paths = self.info.to_s.split('/')
    if paths.size > 0
      return paths[paths.size-1]
    else
      return ""
    end
  end
end
