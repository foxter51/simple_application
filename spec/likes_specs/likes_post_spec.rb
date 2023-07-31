require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe LikesController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  describe 'POST /posts/:post_id/likeable/:likeable_id/likes/:id' do
    before do
      sign_in user
    end

    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user:) }
    let(:comment) { FactoryBot.create(:comment, post:, user:) }

    let(:like) { FactoryBot.create(:like, likeable: comment, user:) }

    before do
      sign_in user
    end

    it 'likes comment' do
      expect do
        post post_comment_likes_path(post_id: post.id, comment_id: comment.id),
             params: {
               like: {
                 likeable_id: comment.id,
                 likeable_type: comment.class.to_s
               }
             }
      end.to change(Like, :count).by(1)
    end

    it 'likes post' do
      expect do
        post post_likes_path(post_id: post.id),
             params: {
               like: {
                 likeable_id: post.id,
                 likeable_type: post.class.to_s
               }
             }
      end.to change(Like, :count).by(1)
    end
  end
end
# rubocop:enable Metrics/BlockLength
