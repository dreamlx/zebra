require 'rubygems'
require 'zip'
class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @products = Product.where(:admin_id => current_user.id)
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
    @serials_grid = initialize_grid(Serial.where(product_id: @product.id),
                    name:'serials')

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
    end
  end

  def create
    @product = Product.new(product_params)
    @product.admin_id = current_user.id
    if @product.save
      redirect_to products_url
    else
      render 'new'
    end
  end

  def create_multiple
    @product = Product.find(params[:id])
    index = Serial.last.id
    params[:product][:how_many].to_i.times do |serial|
      index = index + 1
      @serial = Serial.create(product_id: params[:product][:product_id], serial_no: Digest::MD5.hexdigest(current_user.id.to_s).upcase + '-' + Time.now.to_i.to_s + '-' + index.to_s)
      qr_code(@serial.id)
    end
    redirect_to @product
  end

  def download

  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_url
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to products_url
  end

  private
   def product_params
    params.require(:product).permit(
      :product_name, :product_image, :admin_id, :how_many, :score)
   end
end
