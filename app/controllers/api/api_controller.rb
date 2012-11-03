class Api::ApiController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :set_user

  before_filter :require_api_key

  API_KEY = "REPLACE_ME"

  protected

    def require_api_key
      if request.headers['X-Snap-API-Key'] != API_KEY
        render json: construct_json(401), status: :unauthorized
        return
      end
    end

    def construct_json(code, data = nil)
      message = case code
      when 200 then "OK"
      when 401 then "Unauthorized"
      else
        code = 500
        "Server Error"
      end
      {
        meta: {
          code: code,
          message: message
        },
        data: data
      }
    end
end