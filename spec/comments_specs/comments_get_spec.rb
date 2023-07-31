require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

  describe 'GET /posts/:id/comments' do
    before do
      sign_in user
      @post = FactoryBot.create(:post, user:)
      @comments = FactoryBot.create_list(:comment, 5, post: @post, user:)
      get post_comments_path(@post)
    end

    it 'returns http ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns comments' do
      assigns(:comments).should eq(@comments)
    end
  end
end
