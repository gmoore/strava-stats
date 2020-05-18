# Strava Stats

A little terminal application I threw together because I was curious about some of my Strava stats

# Before You Begin

You'll need:

* Ruby. Anything recent is probably fine
* Bundler
* A Strava Access token

# Setup

* Create a file called ".env"
* Add this line to ".env"

`STRAVA_ACCESS_TOKEN=(your_access_token)`

* `bundle install`

# Usage

There are two scripts. One to load the data and one to work with the data offline.

`ruby load_activities.rb`

This will save a local JSON file of all of your Strava activities

`ruby print_report.rb`

This will print out some stats on your rides. We only consider outdoor rides. For the power tables we only consider rides with a power source, no virtual or estimated power.
