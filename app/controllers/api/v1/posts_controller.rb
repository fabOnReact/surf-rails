class Api::V1::PostsController < PostsController
  private
  def set_posts
    super
    @posts_json = ActiveModel::Serializer::CollectionSerializer.new(
      @posts, serializer: PostSerializer
    ).as_json
  end
end
