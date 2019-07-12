class PostWorker
  include Sidekiq::Worker

  def perform(*args)
    Post.find(args.first).save
  end
end
