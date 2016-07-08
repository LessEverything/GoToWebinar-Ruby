module GoToWebinar
  module Webinars
    def get_historical_webinars(params = {})
      self.class.get("historicalWebinars", :query => params)
    end

    def get_upcoming_webinars(params = {})
      self.class.get("upcomingWebinars", :query => params)
    end

    def get_webinar(webinar_key)
      self.class.get("webinars/#{webinar_key}")
    end

    def get_webinar_meeting_times(webinar_key)
      self.class.get("webinars/#{webinar_key}/meetingTimes")
    end

    def get_webinars()
      self.class.get("webinars")
    end

    def create_webinar(params = {})
      self.class.post("webinars", :body => params.to_json)
    end

    # TODO: Add tests
    def update_webinar(webinar_key, params = {})
      # TODO: Add support for 'notifyParticipants' (https://developer.citrixonline.com/content/gotowebinar-api-reference#!/Webinars/updateWebinar)
      self.class.put("webinars/#{webinar_key}", :body => params.to_json)
    end
  end
end
