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
      @short_url = find_or_create_url
      @short_url.generate_code if @short_url.code.blank?
      
      if @short_url.save
        render json: { link: code_url(@short_url) }
      else
        render json: {
          errors: @short_url.errors.full_messages
        }
      end
    end

    private

    def find_or_create_url
      ShortUrl.find_by_email_and_full_link(
        params[:email],
        params[:full_link]
      ) || ShortUrl.new(short_url_params)
    end


    def code_url(short_url)
      "#{request.protocol}#{request.host_with_port}/#{short_url.code}"
    end

    def short_url_params
      params.permit(:email, :full_link)
    end
  end
end