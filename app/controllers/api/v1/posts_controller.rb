class Api::V1::PostsController < PostsController
  def index
    super
    posts_json = ActiveModel::Serializer::CollectionSerializer.new(
      @posts, serializer: PostSerializer
    ).as_json

    respond_to do |format|
      format.html { super }
      format.json { render json: posts_json, status: :created, location: api_v1_posts_path }
    end
  end
end
