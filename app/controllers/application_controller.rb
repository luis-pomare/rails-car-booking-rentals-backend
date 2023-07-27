class ApplicationController < ActionController::API
  before_action :set_access_control_headers

  private

  def set_access_control_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
  end
end
