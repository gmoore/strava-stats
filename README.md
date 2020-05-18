# Strava Stats

A little terminal application I threw together because I was curious about some of my Strava stats

# Before You Begin

You'll need:

* Ruby. Anything recent is probably fine
* Bundler
* A Strava Access token

# Setup

### Get a Strava Access Token

This is a bit of a pain. First you'll need to create an application. Then you'll need to use a tool to generate your access token. See details here: https://github.com/dblock/strava-ruby-client#strava-oauth-token

### Set up the Token

* Create a file called ".env"
* Add this line to ".env"

`STRAVA_ACCESS_TOKEN=(your_access_token)`

### Bundle

* `bundle install`

# Usage

There are two scripts. One to load the data and one to work with the data offline.

`ruby load_activities.rb`

This will save a local JSON file of all of your Strava activities

`ruby print_report.rb`

This will print out some stats on your rides. We only consider outdoor rides. For the power tables we only consider rides with a power source, no virtual or estimated power.
