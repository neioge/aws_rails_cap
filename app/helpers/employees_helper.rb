module EmployeesHelper
  # 引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(employee, options = { size: 80 })
    size         = options[:size]
    gravatar_id = Digest::MD5::hexdigest(employee.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: employee.name, class: "gravatar")
  end
end
