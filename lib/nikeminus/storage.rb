module NikeMinus
  class Storage
    JSON_FILE = "#{ENV['HOME']}/.nikeminus"

    def json_file
      JSON_FILE
    end

    def initialize
      bootstrap_json unless File.exists?(json_file)
    end

    def get_user_id
      data = File.open(json_file, 'r')
    end

    def bootstrap_json
      FileUtils.touch json_file
      save!
    end
  end
end
