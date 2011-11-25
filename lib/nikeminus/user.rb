module NikeMinus
  class User
    VALID_ID = %r{^[0-9]+$}

    def self.valid_id?(uid)
      uid = uid.to_s if uid.is_a? Fixnum
      (uid =~ VALID_ID) ? true : false
    end

  end
end
