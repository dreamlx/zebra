require 'rails_helper'

RSpec.describe "StoreAssistants", type: :request do
  describe "GET /store_assistants" do
    it "works! (now write some real specs)" do
      get store_assistants_path
      expect(response).to have_http_status(200)
    end
  end
end
