module NikeMinus
  class User

    def valid_id?(user_id)
      haystack = %r{^[0-9]+$}
      user_id.match(haystack) ?: nil
    end

    def get_user_id
    end

  end
end
