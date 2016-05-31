require 'rails_helper'

RSpec.describe "ShopStores", type: :request do
  describe "GET /shop_stores" do
    it "works! (now write some real specs)" do
      get shop_stores_path
      expect(response).to have_http_status(200)
    end
  end
end
