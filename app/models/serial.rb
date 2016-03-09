class Serial < ActiveRecord::Base
  belongs_to :product
  has_many :scanlogs

  state_machine :state, :initial => :'未绑定' do
    event :scan do
      transition [:'未绑定'] => :'已绑定'
    end
    event :unable do
      transition [:'未绑定', :'已绑定'] => :'作废'
    end
  end
end
