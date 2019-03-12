class ProjectsController < ActionController::Base
  def index
    @projects = Bugsnag::Api.projects(params[:organization_id], auth_token: params[:account_id])
  end

  def show
    respond_to do |format|
      format.html do
        @errors = Bugsnag::Api.errors(params[:id], nil, auth_token: params[:account_id]).sort_by do |error|
          error[:error_class]
        end
      end
      format.csv do
        errors = Bugsnag::Api.errors(params[:id], nil, auth_token: params[:account_id])
        errors = errors.select { |error| error[:id].in?(params[:error_ids]) }
        send_data Report.new(params[:account_id], params[:id], errors).generate, type: 'text/csv; charset=utf-8; header=present'
      end
    end
  end
end
