times = ["2019-08-05T07:00:00+00:00", "2019-08-05T08:00:00+00:00", "2019-08-06T06:00:00+00:00"]
FactoryBot.define do
  factory :forecast do
    time { times[rand(0..2)] } 
    swellHeight { [{ "value" => 1}, { "value" => 2 }] } 
    waveHeight { [{ "value" => 1}, { "value" => 2 }] }
    seaLevel { [{"value"=>0.27, "source"=>"sg"}] }
  end
end
