task :setup do
  hash = Hash.new

  puts "Welcome to your new Grooveshark Scrobber."
  print "To start, what is your Grooveshark username? "
  STDOUT.flush
  hash['grooveshark_name'] = gets

  puts "Now you're going to need a Last.fm API Key / Secret.  You can get it here: http://www.last.fm/api/account"
  print "Now what is your Last.fm api_key? "
  STDOUT.flush
  hash['api_key'] = gets

  print "Last.fm secret? "
  STDOUT.flush
  hash['api_secret'] = gets

  lastfm = Lastfm.new(api_key, api_secret)
  token = lastfm.auth.get_token

  puts "OK, now please go to http://www.last.fm/api/auth/?api_key=#{api_key}&token=#{token} and aproove this application to accsess your Last.fm user"
  print "Press anything to continue "
  STDOUT.flush
  gets

  hash['session'] = lastfm.auth.get_session(token)

  File.open('config.yml', 'w') do |f|
    YAML.dump(hash, f)
  end

  puts "Looks like its all good.  Now just create a cron job pointing to main.rb, running something like every 5-10 mins"
end
