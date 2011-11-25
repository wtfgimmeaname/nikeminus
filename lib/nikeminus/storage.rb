module NikeMinus
  class Storage
    JSON_FILE = "#{ENV['HOME']}/.nikeminus"

    attr_accessor :uid, :json

    def json_file
      JSON_FILE
    end

    def setup(uid)
      @uid  = (uid) if Data.valid_id?(uid)
      @json = Data.build_json(uid)
      save!
    end

    def save!
      File.open(json_file, "w") {|f| f.write(to_json)}
    end

    def to_hash
      { :uid => @uid, :json => @json}
    end

    def to_json
      Yajl::Encoder.encode(to_hash, :pretty => true)
    end

  end
end
