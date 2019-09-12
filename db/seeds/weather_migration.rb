Forecast.destroy_all
Location.update_all(with_forecast: false)
Sidekiq::Cron::Job.destroy_all!
Post.all.each {|post| post.location.set_job }
