class AdminSetting

  def self.file_path
    @file_path ||= Rails.root.join("config/admin_settings.yml")
  end

  def self.initial_load_or_create
    if File.exists? file_path
      @app_settings ||= YAML::load_file file_path
    else
      @app_settings ||= {coversheet_percentage: 59}
      File.open(file_path, 'w+') do |file|
        file.write @app_settings.to_yaml
      end
    end
  end
  initial_load_or_create

  def self.write
    File.open(file_path, 'w+') do |file|
      file.write @app_settings.to_yaml
    end
  end

  def self.[](key)
    @app_settings[key]
  end

  def self.[]=(key, value)
    @app_settings[key] = value
    write
  end

  def self.settings
    @app_settings
  end

end
