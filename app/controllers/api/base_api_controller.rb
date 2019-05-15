module Api
  class BaseApiController < ApplicationController    
    skip_before_action :verify_authenticity_token
  end
end