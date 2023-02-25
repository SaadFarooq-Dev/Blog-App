require 'rails_helper'

RSpec.describe Reply, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:suggestion) do
    create(:suggestion, title: post.title, content: post.content, post_id: post.id, user_id: user.id)
  end
  describe 'Model TestCase' do
    context 'Validations' do
      it { should validate_presence_of :body }
      it { should validate_length_of(:body).is_at_least(2).is_at_most(150) }

      it { should validate_presence_of :suggestion_id }
      it { should validate_presence_of :user_id }
    end

    context 'Associations' do
      it { should belong_to :user }
      it { should belong_to :suggestion }
    end

    context 'Invalidations' do
      let(:object) { create(:reply, user_id: user.id, suggestion_id: suggestion.id) }
      include_examples 'invalidation check', 'body'
      include_examples 'invalidation check', 'suggestion_id'
      include_examples 'invalidation check', 'user_id'
    end

    context 'Destory' do
      let!(:reply) { create(:reply, user_id: user.id, suggestion_id: suggestion.id) }
      it 'is destroyed when suggestion is destroyed' do
        expect { suggestion.destroy }.to change { Reply.count }.by(-1)
        expect { reply.reload }.to raise_error ActiveRecord::RecordNotFound
      end
      it 'is destroyed when User is destroyed' do
        expect { user.destroy }.to change { Reply.count }.by(-1)
        expect { reply.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
