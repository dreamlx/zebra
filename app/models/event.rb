class Event < ActiveRecord::Base

  state_machine :status, :initial => :'未打印' do
    event :print do
      transition [:'未打印'] => :'已打印'
    end
  end
end
