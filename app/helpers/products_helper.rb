module ProductsHelper
  def qr_code(serial_id)
    qrcode = RQRCode::QRCode.new("#{serial_url(serial_id)}")
  end
end
