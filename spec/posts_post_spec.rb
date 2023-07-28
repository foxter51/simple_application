require 'rails_helper'

RSpec.describe PostsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }
  let(:valid_post) { FactoryBot.create(:post, user:) }
  let(:invalid_post) { FactoryBot.create(:post, title: "t" * 101, user:) }

  describe 'POST /posts' do
    it 'creates a new post' do
      expect do
        post posts_path, params: valid_post.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      end.to change(Post, :count).by(1)
    end

    it "doesn't create a new post" do
      expect do
        post posts_path, params: invalid_post
        expect(response).to render_template(:new)
      end
    end
  end
end
