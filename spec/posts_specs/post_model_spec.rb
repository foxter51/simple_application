require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(100) }

    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_most(255) }
  end
end
