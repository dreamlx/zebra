class StoreAssistant < User
  has_many :serials, dependent: :destroy
  
end
