require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:comment) { create(:comment, post_id: post.id, user_id: user.id) }

  describe 'Model TestCase' do
    context 'Validations' do
      it { should validate_presence_of :reason }
      it { should validate_length_of(:reason).is_at_least(10).is_at_most(500) }
      it { should validate_presence_of :reportable_type }
      it { should validate_presence_of :reportable_id }
      it { should validate_presence_of :user_id }
    end

    context 'Associations' do
      it { should belong_to :user }
      it { should belong_to :reportable }
    end

    context 'Invalidations' do
      let(:object) do
        create(:report, :for_post, reportable_id: post.id, reportable_type: post.class.to_s, user_id: user.id)
      end
      include_examples 'invalidation check', 'reason'
      include_examples 'invalidation check', 'reportable_id'
      include_examples 'invalidation check', 'reportable_type'
      include_examples 'invalidation check', 'user_id'
    end

    context 'Destory' do
      let!(:report) do
        create(:report, :for_post, reportable_id: post.id, reportable_type: post.class.to_s, user_id: user.id)
      end
      it 'is destroyed when reportable_object is destroyed' do
        expect { report.reportable.destroy }.to change { Report.count }.by(-1)
        expect { report.reload }.to raise_error ActiveRecord::RecordNotFound
      end
      it 'is destroyed when user is destroyed' do
        expect { user.destroy }.to change { Report.count }.by(-1)
        expect { report.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
