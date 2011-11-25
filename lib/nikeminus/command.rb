module NikeMinus
  class Command
    class << self

      def execute(*args)
        command = args[0]
        option  = args[1]

        return status unless arg
        delegate(command, option)
      end

      def status
        # return setup info
        # name
        # user id info
        # last updated xml
      end

      def delegate(command, option)
        return init(option) if command == 'init'
      end

      def init(user_id)
        return help unless User.valid_id?(user_id)
        xmldoc = XML.new
        xmldoc.uid=(user_id)
        xmldoc.save!
      end

      def help
        text = %{ nikeminus for your nikeplus }
        msg text
      end

      def msg(string)
        puts(string)
      end

    end
  end
end
