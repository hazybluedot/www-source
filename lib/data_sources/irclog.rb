
module Nanoc::DataSources

  class IRCLog < Nanoc::DataSource
    identifier :irclog
    
    class Message
      attr_accessor :time, :nick, :message

      def initialize(time, nick, message)
        @time = time
        @nick = nick
        @message = message
      end
    end

    def message_items(log)
      message_line = /<(?<time>[0-9]{2}:[0-9]{2})>\s+(?<nick>[^:]+):\s(?<message>.*)$/
      date_line = Regexp.new('=== New day: (?<date_string>[^=]+)===')
      date = Date.today 
      messages = []
      case
      when line =~ date_line
        date = Date.parse($~[:date_string])
      when line =~ message_line
        message_datetime = DateTime.new()
        messages << Message.new(message_datetime, $~[:nick], $~[:message])
      end
      messages
    end

    def items
      []
    end
  end
end
