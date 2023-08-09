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

  def top10_posts_by_clock(user, posts)
    @posts = posts
    @subscriber = user

    mail to: @subscriber.email,
         subject: "Daily posts are waiting for you!"
  end
end
