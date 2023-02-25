class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: %i[show update destroy]

  def index
    @user_posts = current_user.posts.all
  end

  def new
    @post = Post.find_by(id: params[:post_id])
    @suggestion = Suggestion.new(title: @post.title, content: @post.content)
  end

  def create
    @suggestion = current_user.suggestions.new(suggestion_params)
    flash[:alert] = @suggestion.errors.full_messages.to_sentence unless @suggestion.save!
    flash[:notice] = 'Your suggestion was successfully created.'
    redirect_to post_path(params[:post_id])
  end

  def update
    @post = @suggestion.post
    authorize @post, policy_class: SuggestionPolicy
    @post.title = @suggestion.title
    @post.content = @suggestion.content
    return unless @post.save!

    flash[:notice] = 'Your post was successfully updated with suggestion.'
    @suggestion.destroy!
    redirect_to suggestions_path
  end

  def show
    authorize @suggestion, policy_class: SuggestionPolicy
  end

  def destroy
    authorize @suggestion, policy_class: SuggestionPolicy
    redirect_to suggestions_url, notice: 'Suggestion was successfully destroyed.' if @suggestion.destroy
  end

  private

  def set_suggestion
    @suggestion = Suggestion.find_by(id: params[:id])
  end

  def suggestion_params
    params.require(:suggestion).permit(:title, :content).merge(post_id: params[:post_id])
  end
end
