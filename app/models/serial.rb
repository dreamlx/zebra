class Serial < ActiveRecord::Base
  belongs_to :product

  state_machine :state, :initial => :'有效' do
    event :scan do
      transition [:'有效'] => :'失效'
    end
  end
end
