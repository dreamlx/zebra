json.user do
  json.(@user, :id, :cell, :openid, :name, :score)
  json.image @user.image if @user.image
end
