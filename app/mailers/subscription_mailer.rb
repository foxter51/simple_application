# Represents mailer for subscriptions
class SubscriptionMailer < ApplicationMailer
  def new_subscription(user)
    @subscriber = user
    @subscribable = user.posts

    mail to: @subscriber.email,
         subject: "You have been successfully subscribed!"
  end

  def new_post_event_send(post, user)
    @post = post
    @subscriber = user

    mail to: @subscriber.email,
         subject: "New post from #{@post.user.name} #{@post.user.lastname}"
  end
end
