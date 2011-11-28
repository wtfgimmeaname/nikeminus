module NikeMinus
  class Storage
    JSON_FILE = "#{APP_ROOT}/public/js/nikeminus.json"
    JSON_OBJECT_VAR = "var NikeData = "

    attr_reader :filedata

    def json_file
      JSON_FILE
    end

    def initialize
      @filedata = read!
    end

    def nike_id
      @nike_id || @filedata["nike_id"]
    end

    def json_data
      @nike_id || @filedata["json_data"]
    end

    def errors
      NikeMinus.errors
    end

    def setup(nike_id)
      data = Data.new
      return errors unless data.valid_id?(nike_id)

      @nike_id   = nike_id
      @json_data = data.build_json
      save!
    end

    def read!
      file_init unless File.exists?(json_file)
      file = File.new(json_file, "r").read
      Yajl::Parser.new.parse(file.gsub(JSON_OBJECT_VAR, ""))
    end

    def save!
      data = JSON_OBJECT_VAR+to_json
      File.open(json_file, "w") {|f| f.write(data)}
    end

    def destroy!
      File.delete(json_file)
    end

    def file_init
      FileUtils.touch json_file
      save!
    end

    def to_hash
      {
        :nike_id => @nike_id,
        :json_data => @json_data,
        :timestamp => Time.now
      }
    end

    def to_json
      Yajl::Encoder.encode(to_hash, :pretty => true)
    end

  end
end
