class PostWorker
  include Sidekiq::Worker

  def perform(args)
    set_post(args)
    execute_job 
  end

  def execute_job
    hourly = @post.camera.location.reload.forecast_hourly
    @post.update(forecast: hourly)
  end

  private
  def set_post(args)
    @post = Post.find_by(id: args["id"])
  end
end
