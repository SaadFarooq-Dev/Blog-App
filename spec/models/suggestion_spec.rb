require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, :with_suggestion, user_id: user.id) }

  describe 'Model TestCase' do
    context 'Validations' do
      it { should validate_presence_of :title }
      it { should validate_presence_of :content }
      it { should validate_presence_of :post_id }
      it { should validate_presence_of :user_id }
      it { should validate_length_of(:title).is_at_least(10).is_at_most(200) }
    end

    context 'Associations' do
      it { should belong_to :user }
      it { should belong_to :post }
      it { should have_many(:replies).dependent(:destroy) }
    end

    context 'Invalidations' do
      let(:object) { Suggestion.last }
      include_examples 'invalidation check', 'title'
      include_examples 'invalidation check', 'content'
      include_examples 'invalidation check', 'post_id'
      include_examples 'invalidation check', 'user_id'
    end

    context 'Destroy' do
      let!(:suggestion) { Suggestion.last }
      it 'is destroyed when user is destroyed' do
        expect { user.destroy }.to change { Suggestion.count }.by(-1)
        expect { suggestion.reload }.to raise_error ActiveRecord::RecordNotFound
      end
      it 'is destroyed when post is destroyed' do
        expect { post.destroy }.to change { Suggestion.count }.by(-1)
        expect { suggestion.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
