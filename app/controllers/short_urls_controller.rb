class ShortUrlsController < ApplicationController
  def new
    @short_url = ShortUrl.new
  end

  def redirect
    @short_url = ShortUrl.find_by_code(params[:id])
    if @short_url
      redirect_to @short_url.full_link
    else
      redirect_to root_path
    end
  end

  def show
    @short_url = ShortUrl.find_by_code(params[:id])
    if @short_url
      render 'show'
    else
      redirect_to root_path
    end
  end

  def create
    @short_url = find_or_create_url
    @short_url.generate_code if @short_url.code.blank?

    if @short_url.save
      redirect_to short_url_path(@short_url.code)
    else
      render 'new'
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
    
  end

  def short_url_params
    params[:short_url].permit(:email, :full_link)
  end
end