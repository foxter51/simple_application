require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_most(100) }
  end
end
