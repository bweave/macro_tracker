require "irb"

class String
  def colorize(*opts)
    IRB::Color.colorize(self, opts.map { |o| o.to_s.upcase })
  end
end

Rails.application.console do
  def _clear_currents
    puts "Clearing currents".colorize(:cyan)
    Current.reset
  end

  def find_user(user_or_id)
    case user_or_id
    when User
      Current.user = user_or_id
    when Integer, String
      Current.user = user.find(user_or_id)
    else
      fail "Don't know how to find #{user_or_id.inspect}"
    end
  end

  def as(user_or_id)
    _clear_currents

    user = find_user(user_or_id)

    puts "Acting as U#{user.id} #{user.name}".colorize(:yellow)
  end

  as(User.first)
end
