class LocationWorker
  include Sidekiq::Worker

  def perform(*args)
    Location.find(args.first).save
  end
end
