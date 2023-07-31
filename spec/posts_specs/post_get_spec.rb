require 'rails_helper'

RSpec.describe PostsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

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
end
