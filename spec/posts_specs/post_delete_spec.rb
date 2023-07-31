require 'rails_helper'

RSpec.describe PostsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

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
