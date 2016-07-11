class User < ActiveRecord::Base
  has_one :record
  has_many :scanlogs
  has_many :useradminrels
  has_many :admins, through: :useradminrels
  mount_uploader :image, ImageUploader

  def User.send_code(cell, code)
    # the cell must exist and more than 11 digits
    # return false unless cell && cell.to_s.length >= 11
    # msg         = "手机验证码：#{code}。"
    # uri         = URI.parse("http://222.73.117.158/msg/HttpBatchSendSM")
    # username    = Rails.application.secrets.sms_username
    # password    = Rails.application.secrets.sms_password
    # res         = Net::HTTP.post_form(uri, account: username, pswd: password, mobile: cell, msg: msg, needstatus: true)
    # batch_code  = res.body.split[1]
    # return (batch_code ? true : false)
    return true
  end

  state_machine :state, :initial => :'提交' do
    event :confirm do
      transition [:'提交', :'否决'] => :'确认'
    end
    event :deny do
      transition [:'提交', :'确认'] => :'否决'
    end
    event :submit do
      transition [:'确认', :'否决'] => :'提交'
    end
  end
end
