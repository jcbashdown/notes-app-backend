class ApiStubController < ApplicationController
  skip_before_action :verify_authenticity_token

  def echo
    render json: params.except(:controller, :action)
  end
end
