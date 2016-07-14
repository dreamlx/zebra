class User < ActiveRecord::Base
  has_one :record
  has_many :scanlogs
  has_many :useradminrels
  has_many :admins, through: :useradminrels
  mount_uploader :image, ImageUploader

  def User.send_code(cell, code)
    # the cell must exist and more than 11 digits
    return false unless cell && cell.to_s.length >= 11
    msg         = code.to_s
    @var        = {}
    @var["code"] = msg
    uri         = URI.parse("https://api.submail.cn/message/xsend.json")
    username    = Rails.application.secrets.sms_appid
    password    = Rails.application.secrets.sms_signature
    project     = Rails.application.secrets.sms_project
    res         = Net::HTTP.post_form(uri, appid: username, to: cell, project: project, signature: password, vars: @var.to_json)
    status      = JSON.parse(res.body)["status"]
    return ((status == "success") ? true : false)
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
