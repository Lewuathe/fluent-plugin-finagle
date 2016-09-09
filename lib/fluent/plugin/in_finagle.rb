require 'fluent/input'
require 'json'
require 'faraday'

module Fluent

  class FinagleInput < Input
    Plugin.register_input('finagle', self)

    config_param :tag, :string, :default => nil
    config_param :finagle_host, :string
    config_param :finagle_port, :string
    config_param :metrics, :string
    config_param :run_interval, :time, :default => 60

    def initialize
      super
    end

    def configure(conf)
      super
    end

    def start
      super
      @finished = false
      @thread = Thread.new(&method(:run_periodic))
      @conn = Faraday.new(:url => "http://#{@finagle_host}:#{@finagle_port}") do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def shutdown
      @finished = true
      @thread.join
      super
    end

    #
    # Main loop
    #
    def run_periodic
      until @finished
        sleep @run_interval

        begin
          response = @conn.get '/admin/metrics.json'
          json_response = JSON.parse(response.body)

          @metrics.split(",").each do |metric|
            router.emit(
              "#{@tag}.#{metric.gsub("/", "_")}",
              Engine.now.to_i,
              {"value" => json_response[metric]}
            )
          end
        rescue => e
          $log.warn "Failed to get Finagle metrics, but ignored: #{e.message}"
        end

      end
    end

  end
end
