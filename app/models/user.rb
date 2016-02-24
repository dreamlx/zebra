class User < ActiveRecord::Base
  has_one :record
  mount_uploader :image, ImageUploader
end
