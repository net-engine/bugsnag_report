class AccountsController < ActionController::Base
  def new
  end

  def create
    redirect_to account_organizations_path(params[:account_token])
  end
end
