class OrganizationsController < ActionController::Base
  def index
    @organizations = Bugsnag::Api.organizations(auth_token: params[:account_id])
  end
end
