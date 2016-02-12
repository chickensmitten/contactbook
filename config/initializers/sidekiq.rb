Sidekiq.configure_server do |config|
  # runs after your app has finished initializing but before any jobs are dispatched.
  config.on(:startup) do
    make_some_singleton
  end
  config.on(:quiet) do
    puts "Got USR1, stopping further job processing..."
  end
  config.on(:shutdown) do
    puts "Got TERM, shutting down process..."
    stop_the_world
  end
end