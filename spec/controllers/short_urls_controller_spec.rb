require 'rails_helper'

describe ShortUrlsController, type: :controller do
  def generate_url(code)
    ShortUrl.create(email: "email@email.com", code: code, full_link: "http://www.google.com/")
  end

  describe "GET #show/:id" do
    describe "with valid code" do
      before(:each) do
        generate_url("abxde")
        get :show, params: { id: 'abxde' }        
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "loads the correct @short_url" do
        expect(assigns(:short_url).code).to eq("abxde")        
      end
    end

    describe "with invalid code" do
      it "is not successful" do
        get :show, params: { id: 'abxde' }
        expect(response).to_not be_success
      end

      it "redirects to the root path" do
        get :show, params: { id: 'abxde' }
        expect(response).to redirect_to(root_path)        
      end
    end
  end
end