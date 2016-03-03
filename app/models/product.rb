class Product < ActiveRecord::Base
  belongs_to :admin
  has_many :extentions, dependent: :destroy
  mount_uploader :product_image, ImageUploader

  validates :product_name, presence: true

  state_machine :state, :initial => :'正常' do
    event :deny do
      transition [:'正常'] => :'无效'
    end
  end
end
