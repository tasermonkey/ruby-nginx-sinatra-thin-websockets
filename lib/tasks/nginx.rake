require_rel 'my_app_configuration'
namespace :nginx do

  task :configure => MyAppConfiguration.nginx_output_file do

  end

  file MyAppConfiguration.nginx_output_file => MyAppConfiguration.nginx_conf_erb do
    MyAppConfiguration.generate_config_file MyAppConfiguration.nginx_conf_erb, MyAppConfiguration.nginx_output_file
  end

  task :start => [MyAppConfiguration.nginx_output_file] do
    sh("#{MyAppConfiguration.nginx_cmd} -c #{MyAppConfiguration.nginx_run_conf}")
  end

  task :quit do
    sh("#{MyAppConfiguration.nginx_cmd} -c #{MyAppConfiguration.nginx_run_conf} -s quit")
  end

  task :stop do
    sh("#{MyAppConfiguration.nginx_cmd} -c #{MyAppConfiguration.nginx_run_conf} -s stop")
  end

  task :restart => [:quit, :start] do
  end

  task :reload do
    sh("#{MyAppConfiguration.nginx_cmd} -c #{MyAppConfiguration.nginx_run_conf} -s reload")
  end

  task :reopen do
    sh("#{MyAppConfiguration.nginx_cmd} -c #{MyAppConfiguration.nginx_run_conf} -s reopen")
  end
end
