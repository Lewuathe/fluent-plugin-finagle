require 'fluent/input'
require 'json'

module Fluent

  class FinagleInput < Input
    Plugin.register_input('finagle', self)

    config_param :tag, :string, :default => nil
    config_param :finagle_url, :string
    config_param :run_interval, :time

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
          tag         = @tag
          value       = 1

          router.emit(
              tag,
              Engine.now.to_i,
              value
          )
        rescue => e
          $log.warn "Failed to get Finagle metrics, but ignored: #{e.message}"
        end

      end
    end

  end
end