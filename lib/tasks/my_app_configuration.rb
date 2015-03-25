module MyAppConfiguration
  def self.app_dir
    File.expand_path Rake.application.rakefile_location
  end

  def self.base_name
    File.basename self.app_dir
  end

  def self.rackup_file
    File.join self.app_dir, 'config.ru'
  end

  def self.temp_dir
    ENV['APP_TMP_DIR'] || File.expand_path('temp', self.app_dir)
  end

  def self.temp_app_dir
    File.join self.temp_dir, 'app'
  end

  def self.log_dir
    File.join self.temp_app_dir, 'logs'
  end

  def self.pids_dir
    File.join self.temp_app_dir, 'pids'
  end

  def self.sockets_dir
    File.join self.temp_app_dir, 'sockets'
  end

  def self.process_conf_dir
    File.join self.temp_app_dir, 'config'
  end

  def self.nginx_conf_erb
    File.expand_path './config/nginx.conf', self.app_dir
  end

  def self.nginx_output_file
    File.join(self.process_conf_dir, 'nginx.conf')
  end

  def self.public_dir
    File.expand_path 'public', self.app_dir
  end

  def self.nginx_cmd
    ENV['NGINX_BIN'] || 'nginx'
  end

  def self.nginx_run_conf
    ENV['NGINX_CONF'] || self.nginx_output_file
  end


  def self.thin_conf_erb
    File.expand_path './config/thin.yml', self.app_dir
  end

  def self.thin_output_file
    File.join(self.process_conf_dir, 'thin.yml')
  end

  def self.thin_cmd
    ENV['THIN_BIN'] || 'thin'
  end

  def self.thin_run_conf
    ENV['THIN_CONF'] || self.thin_output_file
  end

  def self.generate_config_file(input_file, output_file)
    puts "Making \"#{output_file}\" config file"
    require 'erubis'
    FileUtils.mkdir_p [self.log_dir, self.pids_dir, self.sockets_dir, self.process_conf_dir, self.public_dir]
    bindings = {
      app_dir: self.app_dir,
      log_dir: self.log_dir,
      pids_dir: self.pids_dir,
      sockets_dir: self.sockets_dir,
      public_dir: self.public_dir,
      rackup_file: self.rackup_file
    }
    template = Erubis::Eruby.new File.new(input_file).read
    File.open(output_file, 'w') { |f| f.write template.result(bindings) }
  end


end
