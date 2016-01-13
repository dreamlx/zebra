class Record < ActiveRecord::Base
  ITEMS = ["free_charge", "fifty_discount", "thirty_discount", "ten_discount", "red_envelop"]
  belongs_to :user
end
