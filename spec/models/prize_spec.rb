require 'rails_helper'

RSpec.describe Prize, type: :model do
  it "is valid" do
    expect(create(:prize)).to be_valid
  end
end
