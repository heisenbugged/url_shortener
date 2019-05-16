module Api
  class ShortUrlsController < BaseApiController    
    def show
      @short_url = ShortUrl.find_by_code(params[:id])
      if @short_url
        render json: {
          full_link: @short_url.full_link,
          email: @short_url.email
        }
      else
        render json: {
          errors: ["Could not find short url for code '#{params[:id]}'"]
        }
      end
    end

    def new
      @short_url = ShortUrl.new
    end

    def create
      @short_url = ShortUrl.generate(short_url_params)      
      if @short_url.save
        render json: { link: code_url(@short_url) }
      else
        render json: {
          errors: @short_url.errors.full_messages
        }
      end
    end

    private

    def code_url(short_url)
      "#{request.protocol}#{request.host_with_port}/#{short_url.code}"
    end

    def short_url_params
      params.permit(:email, :full_link)
    end
  end
end