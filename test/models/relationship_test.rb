require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: users(:Haruki).id, followed_id: users(:Misato).id )
  end
  
  test "should be valid" do
    assert @relationship.valid?
  end
  
  test "relationhip require follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end
  
  test "relationship require folllowed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
