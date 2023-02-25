class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :updated_at, :content
  belongs_to :user
  def content
    object.content.body.to_s
  end
end
