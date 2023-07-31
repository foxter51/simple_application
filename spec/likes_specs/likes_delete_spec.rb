require 'rails_helper'

RSpec.describe LikesController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  describe 'DELETE /posts/:post_id/likeable/:likeable_id/likes/:id' do
    before do
      sign_in user
    end

    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user:) }
    let(:comment) { FactoryBot.create(:comment, post:, user:) }

    let!(:like) { FactoryBot.create(:like, likeable: comment, user:) }

    it 'deletes like from comment' do
      delete post_comment_like_path(post_id: post.id, comment_id: comment.id, id: like)
      expect(Like.count).to eq(0)
    end

    let!(:like) { FactoryBot.create(:like, likeable: post, user:) }

    it 'deletes like from post' do
      delete post_like_path(post_id: post.id, id: like)
      expect(Like.count).to eq(0)
    end
  end
end
