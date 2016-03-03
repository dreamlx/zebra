class Extention < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :extention_name, presence: true
  validates :extention_value, presence: true
end
