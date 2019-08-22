class Api::V1::PostsController < PostsController
  before_action :decorate_posts, only: [:index]
  
  private
  def decorate_posts
    set_posts
    @posts_json = ActiveModel::Serializer::CollectionSerializer.new(
      @posts, serializer: PostSerializer
    ).as_json
  end
end
