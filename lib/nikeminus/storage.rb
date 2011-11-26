module NikeMinus
  class Storage
    JSON_FILE = "#{ENV['HOME']}/.nikeminus"

    attr_reader :filedata

    def initialize
      @filedata = read_file
    end

    def json_file
      JSON_FILE
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

    def read_file
      file_init unless File.exists?(json_file)
      Yajl::Parser.new.parse(File.new(json_file, 'r'))
    end

    def file_init
      FileUtils.touch json_file
      save!
    end

    def save!
      File.open(json_file, "w") {|f| f.write(to_json)}
    end

    def destroy!
      File.delete(json_file)
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
