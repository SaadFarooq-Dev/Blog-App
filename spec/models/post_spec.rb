require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  describe 'Model TestCase' do
    context 'Validations' do
      it { should validate_presence_of :title }
      it { should validate_length_of(:title).is_at_least(10).is_at_most(200) }
      it { should validate_presence_of :content }
      it { should validate_presence_of :user_id }
    end

    context 'Associations' do
      it { should belong_to :user }
      it { should have_many(:likes).dependent(:destroy) }
      it { should have_many(:suggestions).dependent(:destroy) }
      it { should have_many(:comments).dependent(:destroy) }
      it { should have_many(:reports).dependent(:destroy) }
    end

    context 'Invalidations' do
      let(:object) { create(:post, user_id: user.id) }
      include_examples 'invalidation check', 'title'
      include_examples 'invalidation check', 'content'
      include_examples 'invalidation check', 'user_id'
    end

    context 'Destory' do
      let!(:post) { create(:post, user_id: user.id) }
      it 'is destroyed when user is destroyed' do
        expect { user.destroy }.to change { Post.count }.by(-1)
        expect { post.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
