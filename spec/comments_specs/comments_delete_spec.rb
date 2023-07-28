require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  describe 'DELETE /posts/:id/comments' do
    before do
      sign_in user
    end

    let(:post) { FactoryBot.create(:post, user:) }
    let!(:comment) { FactoryBot.create(:comment, post:, user:) }

    it 'deletes the comment' do
      delete post_comment_path(post, comment)
      expect(Comment.count).to eq(0)
    end
  end
end
