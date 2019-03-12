require 'csv'

class Report
  attr_reader :auth_token, :project_id, :errors

  def initialize(auth_token, project_id, errors)
    @auth_token = auth_token
    @project_id = project_id
    @errors = errors
  end

  def generate
    CSV.generate do |csv|
      csv << ['Context', 'Error Class', 'Received at']
      errors.each do |error|
        events = Bugsnag::Api.error_events(project_id, error[:id], per_page: 100, auth_token: auth_token)
        last_response = Bugsnag::Api.last_response
        until last_response.rels[:next].nil?
          last_response = last_response.rels[:next].get
          events = events.concat last_response.data
        end
        events.each do |event|
          csv << [error[:context], error[:error_class], event[:received_at]]
        end
      end
    end
  end
end
