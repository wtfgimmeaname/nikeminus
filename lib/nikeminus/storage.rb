module NikeMinus
  class Storage
    JSON_FILE = "#{ENV['HOME']}/.nikeminus"

    attr_accessor :uid, :data, :json

    def initialize
      @data = Data.new
    end

    def json_file
      JSON_FILE
    end

    def errors
      NikeMinus.errors
    end

    def setup(uid)
      return errors unless @data.valid_id?(uid)
      @uid  = uid
      @json = @data.build_json
      save!
    end

    def save!
      puts to_json
      #File.open(json_file, "w") {|f| f.write(to_json)}
    end

    def to_hash
      { :uid => @uid, :json => @json }
    end

    def to_json
      Yajl::Encoder.encode(to_hash, :pretty => true)
    end

  end
end
