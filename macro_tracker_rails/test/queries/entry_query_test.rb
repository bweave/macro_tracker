require "test_helper"

class EntryQueryTest < ActiveSupport::TestCase
  setup { Current.user = users(:brian) }

  def subject
    @subject ||= EntryQuery.new
  end

  test "#call" do
    assert true
  end
end
