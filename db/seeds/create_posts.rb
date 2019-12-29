gps_down = [-8.814377, 115.088349]
# Camera Down
# camera_down = Camera.new(latitude: gps_down[0], longitude: gps_down[1], location: Location.find_by(name: "Uluwatu"))
# camera_down.save
camera_down = Camera.find_by(latitude: gps_down[0], longitude: gps_down[1])

# Uluwatu Down

url = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574744018/uluwatu_camera_3_2_best_261119_gec7vf.mp4"
poster = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574744018/uluwatu_camera_3_2_best_261119_gec7vf.png"
time = Time.zone.local(2019, 11, 25, 23, 30, 00)
forecast = {
 "windSpeed"=>3.5,
 "waveHeight"=>1,
 "swellHeight"=>1,
 "swellPeriod"=>13,
 "optimal_wind"=>true,
 "optimal_swell"=>true,
 "waveDirection"=>204,
 "windDirection"=>221,
 "swellDirection"=>204,
}

video = { url: url, poster: poster }
post = Post.new(forecast: forecast, user: User.find_by(email: 'fabrizio.bertoglio@gmail.com'), latitude: gps_down[0], longitude: gps_down[1], created_at: time, video: video)
post.camera = camera_down
post.save

# Uluwatu Single Finn
url = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574745755/uluwatu_camera_2_2_best_261119_ny7sid.mp4"
url = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574745755/uluwatu_camera_2_2_best_261119_ny7sid.png"
gps_up = [-8.814997, 115.088888]
time = Time.zone.local(2019, 11, 25, 23, 30, 00)
forecast = {
 "windSpeed"=>3.5,
 "waveHeight"=>1,
 "swellHeight"=>1,
 "swellPeriod"=>13,
 "optimal_wind"=>true,
 "optimal_swell"=>true,
 "waveDirection"=>204,
 "windDirection"=>221,
 "swellDirection"=>204,
}

video = { url: url, poster: poster }
post = Post.create(forecast: forecast, user: User.find_by(email: 'fabrizio.bertoglio@gmail.com'), latitude: gps_up[0], longitude: gps_up[1], created_at: time, video: video)

# Uluwatu Up first place
video_first_place = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574744004/uluwatu_camera_1_1_261119_cob1ld.mp4"
poster_first_place = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574744004/uluwatu_camera_1_1_261119_cob1ld.png"
gps_first_place = [-8.815366, 115.089045]
time = Time.zone.local(2019, 11, 25, 23, 30, 00)
forecast = {
 "windSpeed"=>3.5,
 "waveHeight"=>1,
 "swellHeight"=>1,
 "swellPeriod"=>13,
 "optimal_wind"=>true,
 "optimal_swell"=>true,
 "waveDirection"=>204,
 "windDirection"=>221,
 "swellDirection"=>204,
}

video = { url: video_first_place, poster: poster_first_place }
post = Post.create(forecast: forecast, user: User.find_by(email: 'fabrizio.bertoglio@gmail.com'), latitude: gps_first_place[0], longitude: gps_first_place[1], created_at: time, video: video)

# Padang Bridge
url = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574748234/padang_camera_1_1_261119_mlb7mg.mp4"
poster = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574748234/padang_camera_1_1_261119_mlb7mg.png"
gps = [-8.811752, 115.104264]
time = Time.zone.local(2019, 11, 25, 24, 00, 00)
forecast = {
 "windSpeed"=>3.5,
 "waveHeight"=>0.5,
 "swellHeight"=>0.5,
 "swellPeriod"=>13,
 "optimal_wind"=>true,
 "optimal_swell"=>true,
 "waveDirection"=>204,
 "windDirection"=>221,
 "swellDirection"=>204,
}

video = { url: url, poster: poster }
post = Post.create(forecast: forecast, user: User.find_by(email: 'fabrizio.bertoglio@gmail.com'), latitude: gps[0], longitude: gps[1], created_at: time, video: video)

# Padang Restaurant
url = 'https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574748235/padang_camera_2_1_261119_hm9t0m.mp4'
poster = 'https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574748235/padang_camera_2_1_261119_hm9t0m.png'
gps = [-8.811864, 115.102336]
time = Time.zone.local(2019, 11, 25, 24, 00, 00)
forecast = {
 "windSpeed"=>3.5,
 "waveHeight"=>0.5,
 "swellHeight"=>0.5,
 "swellPeriod"=>13,
 "optimal_wind"=>true,
 "optimal_swell"=>true,
 "waveDirection"=>204,
 "windDirection"=>221,
 "swellDirection"=>204,
}

video = { url: url, poster: poster }
post = Post.create(forecast: forecast, user: User.find_by(email: 'fabrizio.bertoglio@gmail.com'), latitude: gps[0], longitude: gps[1], created_at: time, video: video)

# Kuta Mc Donald
url = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574749726/kuta_camera_2_1_261119_zne5yu.mp4"
poster = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574749726/kuta_camera_2_1_261119_zne5yu.png"
gps = [-8.719795, 115.169050]
time = Time.zone.local(2019, 11, 25, 23, 00, 00)
forecast = {
 "windSpeed"=>3.5,
 "waveHeight"=>0.5,
 "swellHeight"=>0.5,
 "swellPeriod"=>13,
 "optimal_wind"=>true,
 "optimal_swell"=>true,
 "waveDirection"=>204,
 "windDirection"=>221,
 "swellDirection"=>204,
}

video = { url: url, poster: poster }
post = Post.create(forecast: forecast, user: User.find_by(email: 'fabrizio.bertoglio@gmail.com'), latitude: gps[0], longitude: gps[1], created_at: time, video: video)

# Kuta Istana
url = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574749725/kuta_camera_1_2_261119_best_w7wakr.mp4"
poster = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574749725/kuta_camera_1_2_261119_best_w7wakr.png"
gps = [-8.715630, 115.168035]
time = Time.zone.local(2019, 11, 25, 23, 00, 00)
forecast = {
 "windSpeed"=>3.5,
 "waveHeight"=>0.5,
 "swellHeight"=>0.5,
 "swellPeriod"=>13,
 "optimal_wind"=>true,
 "optimal_swell"=>true,
 "waveDirection"=>204,
 "windDirection"=>221,
 "swellDirection"=>204,
}

video = { url: url, poster: poster }
post = Post.create(forecast: forecast, user: User.find_by(email: 'fabrizio.bertoglio@gmail.com'), latitude: gps[0], longitude: gps[1], created_at: time, video: video)

# Kuta Istana in water 
url = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1576331424/kuta_cam_1_1_14122019_nrefza.mp4"
poster = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1576331424/kuta_cam_1_1_14122019_nrefza.png"
time = Time.zone.local(2019, 12, 13, 23, 00, 00)
gps = [-8.715938, 115.166881]
forecast = {
 "windSpeed"=>3.5,
 "waveHeight"=>0.5,
 "swellHeight"=>0.5,
 "swellPeriod"=>13,
 "optimal_wind"=>true,
 "optimal_swell"=>true,
 "waveDirection"=>204,
 "windDirection"=>221,
 "swellDirection"=>204,
}

video = { url: url, poster: poster }
post = Post.create(forecast: forecast, user: User.find_by(email: 'fabrizio.bertoglio@gmail.com'), latitude: gps[0], longitude: gps[1], created_at: time, video: video)

# Sindhu Beach
url = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574751984/sanur_camera_1_3_best_261119_sermvh.mp4"
poster = "https://res.cloudinary.com/dhhzzcjq0/video/upload/v1574751984/sanur_camera_1_3_best_261119_sermvh.png"
gps = [-8.684549, 115.264632]
time = Time.zone.local(2019, 11, 25, 25, 00, 00)
forecast = {
 "windSpeed"=>3.5,
 "waveHeight"=>1,
 "swellHeight"=>1,
 "swellPeriod"=>13,
 "optimal_wind"=>true,
 "optimal_swell"=>false,
 "waveDirection"=>204,
 "windDirection"=>221,
 "swellDirection"=>204,
}

video = { url: url, poster: poster }
post = Post.create(forecast: forecast, user: User.find_by(email: 'fabrizio.bertoglio@gmail.com'), latitude: gps[0], longitude: gps[1], created_at: time, video: video)
