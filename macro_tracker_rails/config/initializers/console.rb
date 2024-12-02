Rails.application.console do
  Current.user = User.first
  puts ">> Current.user = #{Current.user.name}"
end
