module Helpers
  def status_is_ok
    expect(response).to have_http_status(:ok)
  end

  def status_is_redirect
    expect(response).to have_http_status(:redirect)
  end

  def not_authorized_flash
    expect(flash[:alert]).to eq('You are not authorized to perform this action.')
  end

  def devise_authentication_redirect
    expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
  end

  def created_suggestion_object
    Suggestion.last
  end

  def created_reply_object
    Reply.last
  end
end
