require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:sec_user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:comment) { create(:comment, post_id: post.id, user_id: user.id) }
  let!(:comment_reply) { create(:comment, post_id: post.id, user_id: sec_user.id, parent_id: comment.id) }

  describe 'Model TestCase' do
    context 'Validations' do
      let(:object_my) { create(:user) }
      it { should validate_presence_of :body }
      it { should validate_length_of(:body).is_at_least(2).is_at_most(200) }
      it { should validate_presence_of :post_id }
      it { should validate_presence_of :user_id }
    end

    context 'Associations' do
      it { should belong_to :user }
      it { should have_many(:likes).dependent(:destroy) }
      it { should have_many(:comments).dependent(:destroy) }
      it { should have_many(:reports).dependent(:destroy) }
      it { should have_one_attached :image }
    end

    context 'Invalidations' do
      let(:object) { create(:comment, post_id: post.id, user_id: user.id) }
      include_examples 'invalidation check', 'body'
      include_examples 'invalidation check', 'post_id'
      include_examples 'invalidation check', 'user_id'
    end

    it 'has a parent comment and is a valid comment' do
      expect(comment_reply.parent_id).to eq(comment.id)
      expect(comment_reply).to be_valid
    end

    it 'has a reply' do
      expect(comment.comments.first.id).to eq(comment_reply.id)
    end
    context 'Destory' do
      it 'is destroyed when user is destroyed' do
        expect { user.destroy }.to change { Comment.count }.by(-2)
        expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
      end
      it 'is destroyed when post is destroyed' do
        expect { post.destroy }.to change { Comment.count }.by(-2)
        expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
