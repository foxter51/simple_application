require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user:) }
  let(:valid_comment) { FactoryBot.create(:comment, post:, user:) }
  let(:invalid_comment) { FactoryBot.create(:comment, text: "c" * 101, post:, user:) }

  describe 'POST /posts/:id/comments' do
    before do
      sign_in user
    end

    it 'creates a new comment' do
      expect do
        post post_comments_path(post, valid_comment)
      end.to change(Comment, :count).by(1)
    end

    it "doesn't create a new comment" do
      expect do
        post post_comments_path(post, invalid_comment)
        expect(response).to have_http_status(302)
      end
    end
  end
end
