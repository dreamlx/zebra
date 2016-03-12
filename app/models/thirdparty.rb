class Thirdparty < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :code, presence: true

  state_machine :state, :initial => :'正常' do
    event :deny do
      transition [:'正常'] => :'无效'
    end
  end
end
