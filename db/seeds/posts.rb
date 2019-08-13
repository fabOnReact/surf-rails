bondi_all = ['bondi_0466.JPG','bondi_0467.JPG','bondi_0468.JPG','bondi_0471.JPG','bondi_0472.JPG','bondi_0473.JPG','bondi_0484.JPG','bondi_0494.JPG','bondi_0503.JPG','bondi_0504.JPG','bondi_0505.JPG','bondi_0506.JPG','bondi_0507.JPG','bondi_0511.JPG','bondi_0512.JPG','bondi_0513.JPG','bondi_0523.JPG','bondi_0554.JPG','bondi_0567.JPG','bondi_0568.JPG','bondi_0569.JPG','bondi_0570.JPG','bondi_0571.JPG','bondi_0572.JPG','bondi_0573.JPG','bondi_0596.JPG']

bondi = ['bondi_0596.JPG', 'bondi_0571.JPG', 'bondi_0569.JPG', 'bondi_0568.JPG', 'bondi_0554.JPG', 'bondi_0523.JPG', 'bondi_0513.JPG', 'bondi_0471.JPG', 'bondi_0468.JPG']
balangan = ['balangan_0728.JPG','balangan_0732.JPG','balangan_0733.JPG','balangan_0735.JPG','balangan_0736.JPG','balangan_0737.JPG','balangan_0739.JPG']
kuta = ['kuta_0687.JPG']

domain = 'https://surfcheck.s3.eu-central-1.amazonaws.com'

user = User.create(email: "admin@user.com", password: "fabrizio") unless user = User.find_by(email: "admin@user.com")

balangan.each do |picture_name|
  image_url = "#{domain}/#{picture_name}"
  location = Location.find_by(name: "Balangan")
  post = Post.new(user: user, longitude: location.longitude, latitude: location.latitude)
  post.remote_picture_url = image_url
  post.save
  puts "post saved, picture url: #{post.picture.url}" if post.valid?
  puts post.errors.full_messages unless post.valid?
end

bondi.each do |picture_name|
  image_url = "#{domain}/#{picture_name}"
  location = Location.find_by(name: "Bondi Beach")
  post = Post.new(user: user, longitude: location.longitude, latitude: location.latitude)
  post.remote_picture_url = image_url
  post.save
  puts "post saved, picture url: #{post.picture.url}" if post.valid?
  puts post.errors.full_messages unless post.valid?
end

kuta.each do |picture_name|
  image_url = "#{domain}/#{picture_name}"
  location = Location.find_by(name: "Kuta Beach")
  post = Post.new(user: user, longitude: location.longitude, latitude: location.latitude)
  post.remote_picture_url = image_url
  post.save
  puts "post saved, picture url: #{post.picture.url}" if post.valid?
  puts post.errors.full_messages unless post.valid?
end
