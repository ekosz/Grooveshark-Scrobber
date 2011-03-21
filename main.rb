require 'lastfm'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

# Load user sensive data
config = YAML.load(File.open('config.yml'))

# Set up the recent tracks from grooveshark rss feed
rss_content = ''
open('http://api.grooveshark.com/feeds/1.0/users/'+
     config['grooveshark_name']+
     '/recent_listens.rss') do |o| 
  rss_content = o.read
end
rss = RSS::Parser.parse(rss_content, false)

# Set up the Last.fm API wrapper
lastfm = Lastfm.new(config['api_key'], config['api_secret'])
lastfm.session = config['session']

# Go throw each recently played track, parsing it
# Scrobble it, if it hasn't been already
rss.items.each do |item|
  if item.date.to_time > config['last_scrobble'].to_time
    title = item.gsub #stuff
    author = item.gsub #stuff
    lastfm.scobble(title, author)
  end
end
# Update the config file with the most recently scrobbled track
config['last_scobble'] = rss.items[-1].date
File.write 'config.yml', 'w' do |f|
  YAML.write(config, f)
end
