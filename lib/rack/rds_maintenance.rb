require "json"

module Rack
  class RdsMaintenance
    def initialize(app, options = {})
      @app = app
      @options = {
        path: "/rack_rds_maintenance",
        before_maintenance: -> {},
        after_maintenance: -> {},
      }.merge(options)
    end

    def call(env)
      if env["PATH_INFO"] == @options[:path]
        check(env)
      else
        @app.call(env)
      end
    end

    private

    def check(env)
      case env["x-amz-sns-message-type"]
      when "Notification"
        notification(env)
      when "SubscriptionConfirmation"
        subscribe(env)
      end
      [204, {}, ""]
    end

    def subscribe(env)
      body_json = JSON.parse(env["rack.input"].gets)
      Net::HTTP.get(body_json["SubscribeURL"])
    end

    def notification(env)
      body = env["rack.input"].gets
      if body.include?("RDS-EVENT-0026") # FIXME: real event
        @options[:before_maintenance].call
      elsif body.include?("RDS-EVENT-0027") # FIXME:  real event
        @options[:after_maintenance].call
      end
    end
  end
end
