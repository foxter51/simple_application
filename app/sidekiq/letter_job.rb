# Represents job to send a letter
class LetterJob
  include Sidekiq::Job

  def perform
    User.find_each do |user|
      @posts = user.subscribed_posts.top(10)
      SubscriptionMailer.top10_posts_by_clock(user, @posts).deliver_later if @posts.any?
    end
  end
end
