require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe 'Suggestions', type: :request do
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'when user is signed in' do
      it 'displays all suggestions' do
        sign_in(user)
        get suggestions_path
        status_is_ok
      end
    end
    context 'when user is not signed in' do
      it 'Redriect back to sign in view' do
        get suggestions_path
        devise_authentication_redirect
        status_is_redirect
      end
    end
  end

  describe 'GET #show' do
    context 'When authorized user sign in' do
      let(:user_second) { User.second }
      it 'shows the suggestion page' do
        user_second.confirm
        sign_in(user_second)
        get suggestion_path(created_suggestion_object)
        status_is_ok
      end
    end
    context 'When unauthorized user sign in' do
      it 'shows the suggestion page' do
        sign_in(user)
        get suggestion_path(created_suggestion_object)
        status_is_redirect
        not_authorized_flash
      end
    end
  end

  describe 'POST PUT DESTROY Actions' do
    let(:my_post) { create(:post, user_id: user.id) }
    let(:param) do
      { suggestion: { title: my_post.title, content: my_post.content, user_id: user.id, post_id: my_post.id } }
    end
    describe 'POST #create' do
      context 'when user is signed in' do
        it 'create a suggestion' do
          sign_in(user)
          get new_post_suggestion_path(my_post)
          status_is_ok
          post post_suggestions_path, params: param
          expect(flash[:notice]).to eq('Your suggestion was successfully created.')
          status_is_redirect
          expect(created_suggestion_object.post_id).to eq(my_post.id)
        end
      end
      context 'when user is not signed in' do
        it 'does not create a suggestion' do
          get new_post_suggestion_path(my_post)
          status_is_redirect
          devise_authentication_redirect
        end
      end
    end

    describe 'PUT #update' do
      before(:each) do
        sign_in(user)
      end
      context 'when authorized user sign in' do
        it 'Updates post with the provided suggestion' do
          get new_post_suggestion_path(my_post)
          param[:suggestion][:title] = 'This is the title of the suggested post'
          post post_suggestions_path, params: param
          put suggestion_path(created_suggestion_object)
          status_is_redirect
          my_post.reload
          expect(flash[:notice]).to eq('Your post was successfully updated with suggestion.')
          expect(my_post.title).to eq('This is the title of the suggested post')
        end
      end
      context 'when unauthorized user sign in' do
        it 'does not update post with the provided suggestion' do
          put suggestion_path(created_suggestion_object)
          status_is_redirect
          not_authorized_flash
        end
      end
    end

    describe 'DELETE #destroy' do
      before(:each) do
        sign_in(user)
      end
      context 'When authorized user sign in' do
        it 'deletes the suggestion suggested' do
          get new_post_suggestion_path(my_post)
          post post_suggestions_path, params: param
          get suggestion_path(created_suggestion_object)
          status_is_ok
          delete suggestion_path(created_suggestion_object)
          status_is_redirect
          expect(flash[:notice]).to eq('Suggestion was successfully destroyed.')
        end
      end
      context 'When unauthorized user sign in' do
        it 'does not deletes the suggestion page' do
          delete suggestion_path(created_suggestion_object)
          status_is_redirect
          not_authorized_flash
        end
      end
    end
  end
end
