require_rel 'my_app_configuration'

namespace :webserver do
  task :configure => MyAppConfiguration.thin_output_file do
  end

  file MyAppConfiguration.thin_output_file => MyAppConfiguration.thin_conf_erb do
    MyAppConfiguration.generate_config_file MyAppConfiguration.thin_conf_erb, MyAppConfiguration.thin_output_file
  end

  task :start => [MyAppConfiguration.thin_output_file] do
    sh("#{MyAppConfiguration.thin_cmd} -C #{MyAppConfiguration.thin_run_conf} -R #{MyAppConfiguration.rackup_file} start")
  end

  task :stop do
    sh("#{MyAppConfiguration.thin_cmd} -C #{MyAppConfiguration.thin_run_conf} -R #{MyAppConfiguration.rackup_file} stop")
  end

end
