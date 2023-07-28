require 'rails_helper'

RSpec.describe PostsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }
  let(:valid_post) { FactoryBot.create(:post, user:) }
  let(:invalid_post) { FactoryBot.create(:post, title: "t" * 101, user:) }

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
end
