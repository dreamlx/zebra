class CellCode < ActiveRecord::Base
  validates :cell, presence: true, length: {minimum: 11, maximum: 20}, uniqueness: true
  validates :code, presence: true, length: {is: 4}
end
