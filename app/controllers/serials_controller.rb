class SerialsController < ApplicationController
  skip_before_action :logged_in_admin, only: [:scan, :build_serial]

  def index
    @serials = Serial.all
    @products = Product.where(:admin_id => current_user.id)
    @products_grid = initialize_grid(
      Product.where(admin_id: current_user.id),
      name: 'products_list_grid')
    @serials_grid = initialize_grid(
      Serial.all,
      name: 'all_serials_list_grid')
  end

  def new
    @serial = Serial.new
  end

  def create
    @serial = Serial.new(serial_params)
    if @serial.save
      redirect_to serials_url
    else
      render 'new'
    end
  end

  def query
    # @product = Product.find(params[:product])
    @serials_list_grid = initialize_grid(Serial,
      name: 'serials_list_grid')
  end

  def multi_create
    if params[:serials] && params[:serials][:selected]
      folder = "public/img/qrcode"
      input_filenames = []
      @serials = Serial.where(id: params[:serials][:selected])
      @serials.each do |file|
        input_filenames.push(file.id.to_s + '.png')
      end

      #Attachment name
      filename = '二维码_'+Time.now.strftime('%Y%m%d').to_s+'_'+Time.now.to_i.to_s+'.zip'
      temp_file = Tempfile.new(filename)

      begin
        #This is the tricky part
        #Initialize the temp file as a zip file
        Zip::OutputStream.open(temp_file) { |zos| }

        #Add files to the zip file as usual
        Zip::File.open(temp_file.path, Zip::File::CREATE) do |zipfile|
          input_filenames.each do |filename|
            # Two arguments:
            # - The name of the file as it will appear in the archive
            # - The original file, including the path to find it
            zipfile.add(filename, folder + '/' + filename)
          end
          # zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
        end

        #Read the binary data from the file
        zip_data = File.read(temp_file.path)

        #Send the data to the browser as an attachment
        #We do not send the file directly because it will
        #get deleted before rails actually starts sending it
        send_data(zip_data, :type => 'application/zip', :filename => filename)
      ensure
        #Close and delete the temp file
        temp_file.close
        temp_file.unlink
      end
    else
      @product = Product.find(params[:product])
      @serials_grid = initialize_grid(Serial.where(product_id: @product.id),
                      name:'serials')
    end
  end

  def single_create
    if params[:serials] && params[:serials][:selected]
      folder = "public/img/qrcode"
      input_filenames = []
      @serials = Serial.where(id: params[:serials][:selected])
      @serials.each do |file|
        input_filenames.push(file.id.to_s + '.png')
      end

      #Attachment name
      filename = '二维码_'+Time.now.strftime('%Y%m%d').to_s+'_'+Time.now.to_i.to_s+'.zip'
      temp_file = Tempfile.new(filename)

      begin
        #This is the tricky part
        #Initialize the temp file as a zip file
        Zip::OutputStream.open(temp_file) { |zos| }

        #Add files to the zip file as usual
        Zip::File.open(temp_file.path, Zip::File::CREATE) do |zipfile|
          input_filenames.each do |filename|
            # Two arguments:
            # - The name of the file as it will appear in the archive
            # - The original file, including the path to find it
            zipfile.add(filename, folder + '/' + filename)
          end
          # zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
        end

        #Read the binary data from the file
        zip_data = File.read(temp_file.path)

        #Send the data to the browser as an attachment
        #We do not send the file directly because it will
        #get deleted before rails actually starts sending it
        send_data(zip_data, :type => 'application/zip', :filename => filename)
      ensure
        #Close and delete the temp file
        temp_file.close
        temp_file.unlink
      end
    else
      @product = Product.find(params[:product])
      @serials_grid = initialize_grid(Serial.where(product_id: @product.id),
                      name:'serials')
    end
  end

  def create_multiple
    if params[:product][:how_many].to_i > 100
      params[:product][:how_many] = 100
    end
    @product = Product.find(params[:id])
    index = (Serial.last.id if Serial.any?) || 0
    params[:product][:how_many].to_i.times do |serial|
      index = index + 1
      @serial = Serial.create(product_id: params[:product][:product_id], serial_no: Digest::MD5.hexdigest(current_user.id.to_s).upcase + '-' + Time.now.to_i.to_s + '-' + index.to_s)
      qr_code(@serial.id)
    end
    # redirect_to @product
    redirect_to multi_create_serials_path(product: @product)
  end

  def create_single
    @product = Product.find(params[:id])
    index = (Serial.last.id if Serial.any?) || 0
    index = index + 1
    @serial = Serial.create(product_id: params[:product][:product_id], store_assistant_id: params[:product][:serial][:store_assistants], serial_no: Digest::MD5.hexdigest(current_user.id.to_s).upcase + '-' + Time.now.to_i.to_s + '-' + index.to_s)
    qr_code(@serial.id)
    # redirect_to @product
    redirect_to single_create_serials_path(product: @product)
  end

  def edit
    @serial = Serial.find(params[:id])
  end

  def update
    @serial = Serial.find(params[:id])
    if @serial.update(serial_params)
      redirect_to serials_url
    else
      render 'edit'
    end
  end

  def destroy
    Serial.find(params[:id]).destroy
    redirect_to serials_url
  end

  def scan
    user = User.find_by(cell: params["cell"])
    serial = Serial.find_by(serial_no: params["serial_no"])

    if user.nil?
      user = User.create(cell: params[:cell], score: 0)
    end

    if user && serial.state == "未绑定"
      serial.update_attribute(:phone, params["cell"])
      serial.update_attribute(:user_id, user.id)
      user.update_attribute(:score, (user.score + 20 if user.score) || 20)
      serial.scan
      Scanlog.create(user_id: user.id, serial_id: serial.id, current_score: user.score)
      Useradminrel.find_or_create_by(user_id: user.id, admin_id: serial.product.admin.id)
      render json: {:return => "1", :userid => user.id, :desc => "绑定成功"}, status: 200
    else
      render json: {:return => "0", :userid => serial.user_id, :desc => "绑定失败"}, status: 422
    end
  end

  def build_serial
    serial = Serial.find_by(serial_no: params["serial_no"])
    if serial
      render json: {:return => "1", :desc => "序列号已存在", :product => serial.product.product_name, :product_logo => serial.product.product_logo, :product_image => serial.product.product_image, :cell => serial.phone, :datetime => serial.created_at}, status: 200
    else
      render json: {:return => "0", :desc => "序列号不存在", :product => nil, :product_logo => nil, :product_image => nil, :cell => nil, :datetime => nil}, status: 422
    end
    #
    # if serial.nil?
    #   serial = Serial.create(serial_no: params["serial_no"], phone: params["cell"])
    # end
    # if serial
    #   render json: {:return => "1", :desc => "绑定成功", :cell => serial.phone, :datetime => serial.created_at}, status: 200
    # else
    #   render json: {:return => "0", :desc => "未绑定"}, status: 422
    # end
  end

  def scan_old
    user = User.find_by(openid: params["openid"])
    serial = Serial.find_by(serial_no: params["serial_no"])
    # if serial
    #   if serial.open_id == params["openid"].to_s
    #     render json: {:return => "3", :desc => "你已经扫过"}, status: 200
    #   elsif serial.open_id && serial.open_id != params["openid"].to_s
    #     render json: {:return => "3", :desc => "你已经扫过"}, status: 200
    #   end
    # elsif serial && serial.open_id.nil?
    #   serial.update_attribute(:open_id, params["openid"])
    #   serial.update_attribute(:user_id, user.id)
    #   render json: {:return => "2", :desc => "成功"}, status: 200
    # else
    #   render json: {:return => "1", :desc => "序列号不存在"}, status: 200
    # end
    if user.nil?
      user = User.create(
        openid: params[:openid],
        score: 0)
    end
    if serial && serial.open_id == params["openid"].to_s
      render json: {:return => "2", :desc => "你已经扫过"}, status: 200
    end
    if serial && serial.open_id != params["openid"].to_s && serial.open_id
      render json: {:return => "3", :desc => "别人已经扫过"}, status: 200
    end
    if user && serial.nil? #&& serial.open_id.nil?
      serial = Serial.create(user_id: user.id, open_id: params["openid"], serial_no: params["serial_no"])
      # serial.update_attribute(:open_id, params["openid"])
      # serial.update_attribute(:user_id, user.id)
      user.update_attribute(:score, (user.score + 20 if user.score) || 20)
      render json: {:return => "1", :desc => "成功"}, status: 200
    end
    # if serial.nil?
    #   render json: {}, status: 422
    # end
  end

  private
   def serial_params
    params.require(:serial).permit(:open_id, :phone, :user_id, :serial_no, :product_id, :state, :store_assistant_id)
   end
end
