require 'helper'

class WebinarsTest < Test::Unit::TestCase

  context "methods" do

    setup do
      @c = GoToWebinar::Client.new("12345", "54321")
    end

    should "generate valid get historical webinars" do
      FakeWeb.register_uri(:get, "https://api.citrixonline.com/G2W/rest/organizers/54321/historicalWebinars",:body => '[{"webinarKey":"54321"}]', :content_type => "application/json", :status => ["200", "OK"])
      @r = @c.get_historical_webinars()
      assert_not_nil @r
      assert @r.parsed_response.is_a?(Array)
      assert_not_nil @r.parsed_response.first["webinarKey"]
    end

    should "generate valid upcoming webinars" do
      FakeWeb.register_uri(:get, "https://api.citrixonline.com/G2W/rest/organizers/54321/upcomingWebinars",:body => '[{"webinarKey":"54321"}]', :content_type => "application/json", :status => ["200", "OK"])
      @r = @c.get_upcoming_webinars()
      assert_not_nil @r
      assert @r.parsed_response.is_a?(Array)
      assert_not_nil @r.parsed_response.first["webinarKey"]

    end

    should "generate valid get webinar" do
      FakeWeb.register_uri(:get, "https://api.citrixonline.com/G2W/rest/organizers/54321/webinars/54321",:body => '[{"webinarKey":"54321"}]', :content_type => "application/json", :status => ["200", "OK"])
      @r = @c.get_webinar("54321")
      assert_not_nil @r
      assert @r.parsed_response.is_a?(Array)
      assert_not_nil @r.parsed_response.first["webinarKey"]
    end

    should "generate valid get webinar meeting times" do
      FakeWeb.register_uri(:get, "https://api.citrixonline.com/G2W/rest/organizers/54321/webinars/54321/meetingTimes",:body => '[{"startTime":"2011-04-26T18:00:00Z"}]', :content_type => "application/json", :status => ["200", "OK"])
      @r = @c.get_webinar_meeting_times("54321")
      assert_not_nil @r
      assert @r.parsed_response.is_a?(Array)
      assert_not_nil @r.parsed_response.first["startTime"]
    end

    should "generate valid get webinars" do
      FakeWeb.register_uri(:get, "https://api.citrixonline.com/G2W/rest/organizers/54321/webinars",:body => '[{"webinarKey":"54321"}]', :content_type => "application/json", :status => ["200", "OK"])
      @r = @c.get_webinars()
      assert_not_nil @r
      assert @r.parsed_response.is_a?(Array)
      assert_not_nil @r.parsed_response.first["webinarKey"]
    end

    should "create a webinar with valid params" do
      FakeWeb.register_uri(:post, "https://api.citrixonline.com/G2W/rest/organizers/54321/webinars",:body => '{"webinarKey":"54321"}', :content_type => "application/json", :status => ["200", "OK"])
      @r = @c.create_webinar(creation_params)
      assert_not_nil @r
      assert @r.parsed_response.is_a?(Hash)
      assert_not_nil @r.parsed_response["webinarKey"]
    end
  end

  def creation_params
    {
      "subject":              "string",
      "description":          "string",
      "timeZone":             "America/New_York",
      "type":                 "single_session",
      "isPasswordProtected":  false,
      "times":                [{  "startTime":  (Time.now + 3600).iso8601,
                                  "endTime":    (Time.now + 7200).iso8601   }]
    }
  end
end
