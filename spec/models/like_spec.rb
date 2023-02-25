require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:comment) { create(:comment, post_id: post.id, user_id: user.id) }

  describe 'Model TestCase' do
    context 'Validations' do
      it { should validate_presence_of :likeable_type }
      it { should validate_presence_of :likeable_id }
      it { should validate_presence_of :user_id }
      it do
        validate_uniqueness_of(:user_id).scoped_to(%i[likeable_id likeable_type])
      end
    end

    context 'Associations' do
      it { should belong_to :user }
      it { should belong_to :likeable }
    end

    context 'Invalidations' do
      let(:object) do
        create(:like, :for_post, likeable_id: post.id, likeable_type: post.class.to_s, user_id: user.id)
      end
      include_examples 'invalidation check', 'likeable_id'
      include_examples 'invalidation check', 'likeable_type'
      include_examples 'invalidation check', 'user_id'
    end
    context 'Destory' do
      let!(:like) { create(:like, :for_post, likeable_id: post.id, likeable_type: post.class.to_s, user_id: user.id) }

      it 'is destroyed when likeable_object is destroyed' do
        expect { like.likeable.destroy }.to change { Like.count }.by(-1)
        expect { like.reload }.to raise_error ActiveRecord::RecordNotFound
      end

      it 'is destroyed when user is destroyed' do
        expect { user.destroy }.to change { Like.count }.by(-1)
        expect { like.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
