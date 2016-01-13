require 'rails_helper'

RSpec.describe "records" do
  describe "POST #create" do
    it "get the user info and generate code" do
      user = create(:user)
      post "/records/weixin", {record: {openid: user.openid, cell: user.cell, city: 'shanghai'}}
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq "谢谢参与"
      expect(json["code"]).to be_nil
    end

    it "get the user info and generate code with correct city, maybe failure" do
      user = create(:user)
      prize = create(:prize)
      post "/records/weixin", {record: {openid: user.openid, cell: user.cell, city: prize.city}}
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["message"]).to eq "谢谢参与"
      expect(json["code"]).to be_nil
    end

    it "must have prize with 100% ratio" do
      user = create(:user)
      prize = create(:prize, 
        free_charge_ratio: 1, 
        fifty_discount_ratio: 1, 
        thirty_discount_ratio: 1, 
        ten_discount_ratio: 1, 
        red_envelop_ratio: 1)
      post "/records/weixin", {record: {openid: user.openid, cell: user.cell, city: prize.city}}
      expect(response).to be_success
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)
      expect(json["message"]).not_to eq "谢谢参与"
      expect(json["code"]).not_to be_nil
    end
  end
end