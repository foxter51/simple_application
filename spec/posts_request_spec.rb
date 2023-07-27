require 'rails_helper'

RSpec.describe PostsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }
  let(:valid_post) { FactoryBot.create(:post, user:) }
  let(:invalid_post) { FactoryBot.create(:post, title: "t" * 101, user:) }

  describe 'GET /posts' do
    before do
      sign_in user
      @posts = FactoryBot.create_list(:post, 10, user:)
      get posts_path
    end

    it 'returns http ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns posts' do
      expect(response.body).to include(@posts.first.title)
      expect(response.body).to include(@posts.last.title)
    end
  end

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

  describe 'GET /posts/:id' do
    before do
      sign_in user
      @post = FactoryBot.create(:post, user:)
      get post_path(@post.id)
    end

    it 'gets post' do
      expect(assigns(:post)).to eq(@post)
    end
  end

  describe 'UPDATE /posts/:id' do
    let(:post) { FactoryBot.create(:post, title: 'Post', user:) }

    it "doesn't update the post" do
      expect do
        put posts_path(post), params: invalid_post
        expect(response).to render_template(:edit)
      end
    end

    it 'updates the post' do
      expect do
        put posts_path(post), params: valid_post
        post.reload
        expect(post.title).to eq('Test Post')
      end
    end
  end

  describe 'DELETE /posts/:id' do
    before do
      sign_in user
    end

    let!(:post) { FactoryBot.create(:post, user:) }

    it 'deletes the post' do
      delete post_path(post.id)
      expect(Post.count).to eq(0)
    end
  end
end
