require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Model TestCase' do
    context 'User Validations' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :username }
      it { should validate_presence_of :email }
      it { should validate_presence_of :password }
      it { should validate_length_of(:password).is_at_least(6).is_at_most(70) }
      it { should validate_length_of(:username).is_at_least(5).is_at_most(30) }
      it { should validate_length_of(:name).is_at_least(10).is_at_most(70) }
    end
    context 'User Associations' do
      it { should have_many(:posts).dependent(:destroy) }
      it { should have_many(:likes).dependent(:destroy) }
      it { should have_many(:suggestions).dependent(:destroy) }
      it { should have_many(:comments).dependent(:destroy) }
      it { should have_many(:reports).dependent(:destroy)  }
      it { should have_many(:replies).dependent(:destroy)  }
    end
    context 'Invalidations' do
      let(:object) { create(:user) }
      include_examples 'invalidation check', 'name'
      include_examples 'invalidation check', 'username'
      include_examples 'invalidation check', 'email'
      include_examples 'invalidation check', 'password'
    end
  end
end
