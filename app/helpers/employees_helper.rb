module EmployeesHelper
  # 引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(employee, options = { size: 80 })
    size = options[:size]
    # grabatarのURLはMD５でハッシュ化されているので、Railsのメソッドを使ってメールアドレスをハッシュ化する。
    # また、ダウンケースを使ってメールアドレスを小文字化している。
    gravatar_id = Digest::MD5::hexdigest(employee.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # 変数gravatar_urlに代入されたURLを、最後image_tagで出力する。
    image_tag(gravatar_url, alt: employee.name, class: "gravatar")
  end
end