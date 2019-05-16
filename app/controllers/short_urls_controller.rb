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
    @short_url = ShortUrl.generate(short_url_params)
    if @short_url.save
      redirect_to short_url_path(@short_url.code)
    else
      render 'new'
    end
  end

  private

  def short_url_params
    params[:short_url].permit(:email, :full_link)
  end
end