ROOT = Dir.pwd unless defined? ROOT

module Pushify
  module Juggernaut
  
    if (File.exist?("#{ROOT}/config/juggernaut_hosts.yml"))
      CONFIG_FILE = "#{ROOT}/config/juggernaut_hosts.yml"
    else
      CONFIG_FILE = "#{File.dirname(__FILE__)}/../../install/juggernaut_hosts.yml"
    end

    CONFIG = YAML::load(::ERB.new(IO.read(CONFIG_FILE)).result).freeze
    CR = "\0"

    class << self

      def send_to_all(data)
        fc = {
          :command   => :broadcast,
          :body      => data, 
          :type      => :to_channels,
          :channels  => []
        }
        send_data(fc)
      end

      def send_data(hash, response = false)
        hash[:channels]   = Array(hash[:channels])   if hash[:channels]
        hash[:client_ids] = Array(hash[:client_ids]) if hash[:client_ids]

        res = []
        hosts.each do |address|
          begin
            hash[:secret_key] = address[:secret_key] if address[:secret_key]

            @socket = TCPSocket.new(address[:host], address[:port])
            # the \0 is to mirror flash
            @socket.print(hash.to_json + CR)
            @socket.flush
            res << @socket.readline(CR) if response
          ensure
            @socket.close if @socket and !@socket.closed?
          end
        end
        res.collect {|r| ActiveSupport::JSON.decode(r.chomp!(CR)) } if response
      end

    private

      def hosts
        CONFIG[:hosts].select {|h| 
          !h[:environment] or h[:environment].to_s == ENV['RAILS_ENV']
        }
      end

    end
  end
end
