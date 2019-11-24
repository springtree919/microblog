# Preview all emails at http://72e32011eb5441548e9312594483391d.vfs.cloud9.us-east-1.amazonaws.com/rails/mailers/relationship_mailer/follow_notification
class RelationshipMailerPreview < ActionMailer::Preview
  
  def follow_notification
    user = User.first
    follower = User.second
    RelationshipMailer.follow_notification(user, follower)
  end
end
