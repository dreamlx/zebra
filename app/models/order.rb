class Order < ActiveRecord::Base
  belongs_to :shop_store
  belongs_to :serial
end
