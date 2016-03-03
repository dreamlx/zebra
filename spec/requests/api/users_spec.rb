require 'rails_helper'

RSpec.describe "users" do

  # describe "POST create" do
  #   it "create a new user" do
  #     User.delete_all
  #     valid_attributes = attributes_for(:user)
  #     cell_code = create(:cell_code, cell: valid_attributes[:cell])
  #     post "/api/users", {user: valid_attributes.merge(code: cell_code.code)}
  #     user = User.first
  #     user.reload
  #     expect(response).to be_success
  #     expect(response).to have_http_status(201)
  #     json = JSON.parse(response.body)["user"]
  #     expect(json["id"]).to eq user.id
  #     expect(json["cell"]).to eq user.cell
  #     expect(json["open_id"]).to eq user.open_id
  #   end
  #
  #   it "failed to create a new user without parameter user" do
  #     invalid_attributes = attributes_for(:user).merge(password: "invalid")
  #     post "/api/users", invalid_attributes
  #     expect(response).not_to be_success
  #     expect(response).to     have_http_status(422)
  #   end
  #
  #   it "failed to create a new user with wrong cell code" do
  #     valid_attributes  = attributes_for(:user)
  #     cell_code         = create(:cell_code, cell: valid_attributes[:cell])
  #     post "/api/users", {user: valid_attributes.merge(code: "wrong_code")}
  #     expect(response).not_to be_success
  #     expect(response).to     have_http_status(422)
  #   end
  #
  #   it "failed to create a new user if more than 1 hour" do
  #     User.delete_all
  #     valid_attributes = attributes_for(:user)
  #     cell_code = create(:cell_code, cell: valid_attributes[:cell])
  #     cell_code.update_column(:created_at, (Time.now - 1.hour))
  #     post "/api/users", {user: valid_attributes.merge(code: cell_code.code)}
  #     expect(response).not_to be_success
  #     expect(response).to     have_http_status(422)
  #   end
  # end

  describe "Patch update" do
    it "update name and cell" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      patch "/api/users/#{user.id}", {name: "new_name", cell: "18018559241"}, valid_header
      expect(response).to     be_success
      expect(response).to     have_http_status(200)
      json = JSON.parse(response.body)["user"]
      user.reload
      expect(user.name).to eq "new_name"
      expect(user.cell).to eq "18018559241"
      expect(json["name"]).to eq "new_name"
      expect(json["cell"]).to eq "18018559241"
    end

    it "failed to update name and cell without authentication" do
      user = create(:user)
      patch "/api/users/#{user.id}", {name: "new_name", cell: "18018559241"}
      expect(response).not_to     be_success
      expect(response).to     have_http_status(401)
    end

    # it "failed to update name and cell without parameter of user" do
    #   user = create(:user)
    #   valid_header = {
    #     authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
    #   }
    #   patch "/api/users/#{user.id}", {name: "new_name", cell: "18018559241"}, valid_header
    #   expect(response).not_to be_success
    #   expect(response).to     have_http_status(422)
    # end

    it "failed to update name and cell with invalid id" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      patch "/api/users/invalid", {name: "new_name", cell: "18018559241"}, valid_header
      expect(response).not_to be_success
      expect(response).to     have_http_status(422)
    end

    it "update many attributes" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.openid}")
      }
      new_attributes = {
        cell: "18018559241",
        score: 30,
        image: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/head.png')).read)
      }
      patch "/api/users/#{user.id}", new_attributes, valid_header
      expect(response).to     be_success
      expect(response).to     have_http_status(200)
      json = JSON.parse(response.body)["user"]
      expect(json["id"]).to eq user.id
      expect(json["cell"]).to eq new_attributes[:cell]
      expect(json["score"]).to eq new_attributes[:score]
      expect(json["image"]["image"]["thumb"]["url"]).not_to be_nil
    end
  end
end
