require 'test_helper'

class RelationshipMailerTest < ActionMailer::TestCase
  
  test "follow_notification" do
    user = users(:Haruki)
    follower = users(:Tsukada)
    mail = RelationshipMailer.follow_notification(user, follower)
    assert_equal "#{follower.name}さんがあなたをフォローしました", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name, mail.text_part.body.to_s.encode("UTF-8")
    assert_match follower.name, mail.text_part.body.to_s.encode("UTF-8")
  end
end
