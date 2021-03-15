# config valid only for current version of Capistrano
lock '3.5.0'
set :rbenv_path, '/home/deploy/.rbenv'

set :repo_url,        'git@bitbucket.org:myridz/anant-bajaj.git'
set :application,     'anant_bajaj'
set :user,            'deploy'
#set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma