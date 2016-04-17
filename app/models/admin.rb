class Admin < ActiveRecord::Base
  has_many :products
  has_many :useradminrels
  has_many :users, through: :useradminrels

  has_secure_password
  validates :name, presence: true, uniqueness: true, on: :create
  # validates :name, presence: true, uniqueness: true, on: :update
  validates :address, presence: true
  validates :cell, presence: true, uniqueness: true, on: :create
  validates :cell, numericality: true
  validates_length_of :cell, :is => 11
  # validates :cell, presence: true, uniqueness: true, on: :update
  validates :email, presence: true, uniqueness: true, on: :create
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  # validates :email, presence: true, uniqueness: true, on: :update
  validates :password, presence: true, length: {minimum: 6}, on: :create
  # validates :password, presence: true, length: {minimum: 6}, on: :update


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
