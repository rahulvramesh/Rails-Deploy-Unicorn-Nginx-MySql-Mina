root = "/home/ubuntu/example"
working_directory root
pid "#{root}/shared/pids/unicorn.pid"
stderr_path "#{root}/shared/log/unicorn.stderr.log"
stdout_path "#{root}/shared/log/unicorn.stdout.log"

listen "/home/ubuntu/example/shared/sockets/unicorn.sock"
worker_processes 2
timeout 30
