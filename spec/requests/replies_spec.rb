require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe 'Replies', type: :request do
  let(:user) { create(:user) }
  let(:user_second) { User.first }
  let(:my_post) { create(:post, user_id: user.id) }
  let(:suggestion) do
    create(:suggestion, user_id: user_second.id, post_id: my_post.id, title: 'This is a suggestion',
                        content: 'This is a suggestion content using action text')
  end
  let(:param) do
    { reply: { body: 'This is the First reply for the suggestion', user_id: user.id, suggestion_id: suggestion.id } }
  end

  describe 'POST #create' do
    context 'when authorized user is signed in' do
      it 'It creates a reply' do
        sign_in(user)
        get suggestion_path(suggestion)
        status_is_ok
        post suggestion_replies_path(suggestion), params: param
        status_is_redirect
        expect(created_reply_object.body).to eq('This is the First reply for the suggestion')
        sign_out(user)
        status_is_redirect
        user_second.confirm
        sign_in(user_second)
        status_is_redirect
        get suggestion_path(suggestion)
        param[:reply][:body] = 'This is the Second reply for the suggestion'
        param[:reply][:user_id] = user_second.id
        post suggestion_replies_path(suggestion), params: param
        status_is_redirect
        expect(created_reply_object.body).to eq('This is the Second reply for the suggestion')
      end
    end
    context 'when user is not signed in' do
      it 'Redriect back to sign in view' do
        post suggestion_replies_path(suggestion), params: param
        devise_authentication_redirect
        status_is_redirect
      end
    end
    context 'when unauthorized user is signed in' do
      let(:unauthorized_user) { User.second }
      it 'Redriect back root path with unauthorized flash' do
        unauthorized_user.confirm
        sign_in(unauthorized_user)
        param[:reply][:user_id] = unauthorized_user.id
        post suggestion_replies_path(suggestion), params: param
        not_authorized_flash
      end
    end
  end
end
