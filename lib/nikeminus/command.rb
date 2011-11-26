module NikeMinus
  class Command
    class << self

      def storage
        NikeMinus.storage
      end

      def errors
        NikeMinus.errors
      end

      def show_errors
        errors.each do |k, v|
          msg("Error: #{k}")
        end
      end

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
        storage.setup(user_id)
        show_errors
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
