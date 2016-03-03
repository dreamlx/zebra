class Admin < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :password, presence: true, length: {minimum: 6}

  state_machine :state, :initial => :'待审核' do
    event :confirm do
      transition [:'待审核', :'否决'] => :'通过'
    end
    event :deny do
      transition [:'待审核', :'通过'] => :'否决'
    end
    event :submit do
      transition [:'通过', :'否决'] => :'待审核'
    end
  end
end
