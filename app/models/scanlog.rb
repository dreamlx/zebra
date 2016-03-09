class Scanlog < ActiveRecord::Base
  belongs_to :user
  belongs_to :serial
end
