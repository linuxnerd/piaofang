require 'test_helper'

class BoxofficeCellTest < Cell::TestCase
  test "m1905_boxoffice" do
    invoke :m1905_boxoffice
    assert_select "p"
  end
  
  test "mtime_boxoffice" do
    invoke :mtime_boxoffice
    assert_select "p"
  end
  

end
