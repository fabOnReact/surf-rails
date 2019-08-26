bondi_all = ['bondi_0466.JPG','bondi_0467.JPG','bondi_0468.JPG','bondi_0471.JPG','bondi_0472.JPG','bondi_0473.JPG','bondi_0484.JPG','bondi_0494.JPG','bondi_0503.JPG','bondi_0504.JPG','bondi_0505.JPG','bondi_0506.JPG','bondi_0507.JPG','bondi_0511.JPG','bondi_0512.JPG','bondi_0513.JPG','bondi_0523.JPG','bondi_0554.JPG','bondi_0567.JPG','bondi_0568.JPG','bondi_0569.JPG','bondi_0570.JPG','bondi_0571.JPG','bondi_0572.JPG','bondi_0573.JPG','bondi_0596.JPG']

bondi = ['bondi_0596.JPG', 'bondi_0571.JPG', 'bondi_0569.JPG', 'bondi_0568.JPG', 'bondi_0554.JPG', 'bondi_0523.JPG', 'bondi_0513.JPG', 'bondi_0471.JPG', 'bondi_0468.JPG']
balangan = ['balangan_0728.JPG','balangan_0732.JPG','balangan_0733.JPG','balangan_0735.JPG','balangan_0736.JPG','balangan_0737.JPG','balangan_0739.JPG']
kuta = ['kuta_0687.JPG']

videos = ["bronte-min.mp4", "costline-min.mp4", "surfer-min.mp4", "seaside-min.mp4"]
posters = ["bronte-poster.png", "costline-poster.png", "surfer-poster.png", "seaside-poster.png"]
spots = ["Bronte Reef", "Brace Cove", "Balangan", "Brace Cove"]

domain = 'https://surfcheck.s3.eu-central-1.amazonaws.com'

user = User.create(email: "admin@user.com", password: "fabrizio") unless user = User.find_by(email: "admin@user.com")

spots = ["Bronte Reef", "Brace Cove", "Balangan", "Brace Cove"]

folder = "/seeds/images/"

balangan.each do |picture_name|
  image_url = "#{domain}#{folder}#{picture_name}"
  location = Location.find_by(name: "Balangan")
  post = Post.new(user: user, longitude: location.longitude, latitude: location.latitude, location: location)
  post.remote_picture_url = image_url
  post.save
  puts "post saved, picture url: #{post.picture.url}" if post.valid?
  puts post.errors.full_messages unless post.valid?
end

bondi[0..0].each do |picture_name|
  image_url = "#{domain}#{folder}#{picture_name}"
  random_location = ["Tama Reef", "Bondi Beach", "Bronte Reef", "Mckenzies", "The Boot", "South Bondi"]
  location = Location.find_by(name: random_location[rand(0..5)])
  post = Post.new(user: user, longitude: location.longitude, latitude: location.latitude, location: location)
  post.remote_picture_url = image_url
  post.save
  puts "post saved, picture url: #{post.picture.url}" if post.valid?
  puts post.errors.full_messages unless post.valid?
end

kuta.each do |picture_name|
  image_url = "#{domain}#{folder}#{picture_name}"
  location = Location.find_by(name: "Kuta Beach")
  post = Post.new(user: user, longitude: location.longitude, latitude: location.latitude, location: location)
  post.remote_picture_url = image_url
  post.save
  puts "post saved, picture url: #{post.picture.url}" if post.valid?
  puts post.errors.full_messages unless post.valid?
end

videos.each.with_index do |video_name, index|
  folder = "/seeds/videos/"
  video_url = "#{domain}#{folder}#{video_name}"
  poster_url = "#{domain}#{folder}#{posters[index]}"
  location = Location.find_by(name: spots[index])
  post = Post.new(user: user, longitude: location.longitude, latitude: location.latitude, location: location)
  post.video = { url: video_url, poster: poster_url }
  post.save
  puts "post saved, picture url: #{post.picture.url}" if post.valid?
  puts post.errors.full_messages unless post.valid?
  puts location.inspect  unless post.valid?
end
