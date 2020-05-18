require 'strava-ruby-client'
require 'dotenv/load'

client = Strava::Api::Client.new(access_token: ENV['STRAVA_ACCESS_TOKEN'])

per_page = 100
page_number = 1

all_activities = []

loop do
  ca =  client.athlete_activities(per_page: per_page, page: page_number) 
  all_activities.concat(ca) 
  page_number += 1
  break if ca.count < per_page
end 

all_activities_json = all_activities.map(&:to_json)

File.open("strava_activities.json", "w") { |f| f.write all_activities.to_json }
