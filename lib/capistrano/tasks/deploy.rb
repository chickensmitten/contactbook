namespace :sidekiq do
  task :quiet do
    on roles(:app) do
      puts capture("pgrep -f 'workers' | xargs kill -USR1") 
    end
  end
  desc "Start sidekiq workers"
  task :start do
    sudo "/sbin/start workers"
  end
  desc "Stop sidekiq workers"
  task :stop, :on_error => :continue do
    sudo "/sbin/stop workers"
  end
  desc "Restart sidekiq workers"
  task :restart do
    stop
    start
  end
end


after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:reverted', 'sidekiq:restart'
after 'deploy:published', 'sidekiq:restart'
