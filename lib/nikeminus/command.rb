module NikeMinus
  class Command
    class << self

      def execute(*args)
        command = args[0]
        option  = args[1]

        return help unless args.any?
        delegate(command, option)
      end

      def delegate(command, option)
        return init(option) if command == 'init'
      end

      def init(user_id)
        return help unless User.valid_id?(user_id)

        data = Data.new
        data.uid=(user_id)
        data.build_xml
        if data.xml_valid?
          data.save_json
        end
      end

      def status
        # return setup info
        # name
        # user id info
        # last updated xml
      end

      def help
        help_text = %{
          - Nike- help  -----------------------------------------

          nikeminus init <user_id>          setup your nike-
        }.gsub(/^ {10}/, '')
        msg help_text
      end

      def msg(string)
        puts(string)
      end

    end
  end
end
