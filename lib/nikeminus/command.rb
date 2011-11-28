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

        argless_cmds = %w[update delete launch]
        send(command) if argless_cmds.include? command
        help
      end

      def init(user_id)
        json = storage.setup(user_id)
        return show_errors if errors.any?
        msg "Nike- data setup successful."
      end

      def update
        storage.setup(storage.nike_id)
        msg "Updated Nike- run data."
      end

      def delete
        storage.destroy!
        msg "Your Nike- app has been deleted."
      end

      def launch
        `open ~/Sites/nikeminus/public/index.html`
      end

      def status
        nike_id     = storage.nike_id
        last_update = storage
        config_file = storage.json_file
      end

      def help
        help_text = %{
          --------------------------------------------------------------------
          Nike- help

          nikeminus init <user_id>               Setup your Nike- profile
          nikeminus launch

          nikeminus update                       Update your Nike running data
          nikeminus status                       Show status message (User id, last data update)
          nikeminus delete                       Delete Nike- config file

          nikeminus data xml                     See your data in xml format
          nikeminus data json                    See your data in json format

          For information on Nike- and how to find your Nike user_id visit:
          https://github.com/dustinweatherford/nikeminus

          --------------------------------------------------------------------
        }.gsub(/^ {10}/, '')
        msg help_text
      end

      def msg(string)
        puts(string)
      end

    end
  end
end
