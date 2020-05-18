require 'json'
require 'date'
file = File.open("strava_activities.json")
data = JSON.load(file)

def mtof(m)
  m * 3.281
end

def mtom(m)
  m / 1609
end

def fmtd(d)
  DateTime.parse(d).strftime('%e-%b-%Y')
end

def mpstomph(m)
  m * 2.237
end

def fmtavgpow(p)
  if(p['device_watts'] == true)
    (p['average_watts'] || 0).round(1).to_s
  else
    ""
  end
end

def fmtnppow(p)
  if(p['device_watts'] == true)
    (p['weighted_average_watts'] || 0).round(1).to_s
  else
    ""
  end
end

def show_rides(rides, sort_key)
  puts "== #{sort_key.upcase.gsub("_", " ")} =="
  rides = yield(rides) if block_given?
  sorted_rides = rides.sort_by{|a| a[sort_key]}.reverse


  puts header

  (0..10).each do |f|  
    puts fmt_activity(sorted_rides[f])
  end

  puts " "
  puts " "
end


def fmt_activity(a)
  "#{a['name'][0..20].ljust(25)} #{DateTime.parse(a['start_date_local']).strftime('%e-%b-%Y').rjust(10)} #{Time.at(a['elapsed_time']).utc.strftime("%H:%M:%S").rjust(15)} #{mpstomph(a['average_speed']).round(1).to_s.rjust(6)} #{mpstomph(a['max_speed']).round(1).to_s.rjust(6)} #{fmtavgpow(a).rjust(6)} #{fmtnppow(a).rjust(6)} #{mtof(a['total_elevation_gain']).round(1).to_s.rjust(10)} #{mtom(a['distance']).round(1).to_s.rjust(10)}"
end

def header
  "#{"Name".ljust(25)} #{"Date".rjust(11)} #{"Elapsed Time".rjust(15)} #{"Avg".rjust(6)} #{"Max".rjust(6)} #{"AvPOW".rjust(6)} #{"NpPOW".rjust(6)} #{"Elevation".rjust(10)} #{"Distance".rjust(10)}"
end




puts "Read #{data.count} activities"

h = Hash.new(0)

data.each do |d|
  h[d["type"]] += 1
end

rides = data.select{|g| g['type'] == "Ride"}.select{|g| g['trainer'] == false}

puts "Read #{rides.count} rides, ignoring virtual rides and trainer rides"

show_rides(rides, "total_elevation_gain")
show_rides(rides, "distance")
show_rides(rides, "elapsed_time")
show_rides(rides, "average_speed")
show_rides(rides, "max_speed")
show_rides(rides, "average_speed")
show_rides(rides, "average_watts") {|sorted_rides| sorted_rides.select{|r| r['device_watts'] == true}}
show_rides(rides, "weighted_average_watts") {|sorted_rides| sorted_rides.select{|r| r['device_watts'] == true}}




