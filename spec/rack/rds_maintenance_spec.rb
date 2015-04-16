require "spec_helper"
require "rack/test"

describe Rack::RdsMaintenance do
  include Rack::Test::Methods
  let(:base_app) do
    lambda do |_env|
      [200, { "Content-Type" => "text/plain" }, ["I'm base_app"]]
    end
  end
  let(:app) { Rack::RdsMaintenance.new(base_app, options) }
  let(:options) { {} }

  describe "POST /rack_rds_maintenance" do
    context "Subscription" do
      it "access SubscribeURL" do
        expect(Net::HTTP).to receive(:get)
        post "/rack_rds_maintenance",
             '{"SubscribeURL" : "http://localhost/"}',
             "x-amz-sns-message-type" => "SubscriptionConfirmation"
        expect(last_response.status).to be 204
      end
    end

    context "Notification" do
      let(:store) { {} }

      let(:options) do
        {
          before_maintenance: -> { store[:rds] = "start" },
          after_maintenance: -> { store[:rds] = "finish" },
        }
      end

      context "start maintenance" do
        it "call before_maintenance" do
          post "/rack_rds_maintenance",
               '{"code" : "RDS-EVENT-0026"}', # FIXME: real event
               "x-amz-sns-message-type" => "Notification"
          expect(last_response.status).to be 204
          expect(store[:rds]).to eq "start"
        end
      end

      context "finish maintenance" do
        it "call after_maintenance" do
          post "/rack_rds_maintenance",
               '{"code" : "RDS-EVENT-0027"}', # FIXME: real event
               "x-amz-sns-message-type" => "Notification"
          expect(last_response.status).to be 204
          expect(store[:rds]).to eq "finish"
        end
      end
    end
  end

  describe "other path" do
    it "call base_app" do
      get "/hoge"
      expect(last_response.body).to eq "I'm base_app"
    end
  end
end
