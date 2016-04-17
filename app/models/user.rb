class User < ActiveRecord::Base
  has_one :record
  has_many :scanlogs
  has_many :useradminrels
  has_many :admins, through: :useradminrels
  mount_uploader :image, ImageUploader

  state_machine :state, :initial => :'提交' do
    event :confirm do
      transition [:'提交', :'否决'] => :'确认'
    end
    event :deny do
      transition [:'提交', :'确认'] => :'否决'
    end
    event :submit do
      transition [:'确认', :'否决'] => :'提交'
    end
  end
end
