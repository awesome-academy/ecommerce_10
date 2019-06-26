class Image < ApplicationRecord
  belongs_to :product
  mount_uploader :url_path, PictureUploader
end
