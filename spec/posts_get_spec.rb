require 'rails_helper'

RSpec.describe PostsController, type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { FactoryBot.create(:user) }

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
end
