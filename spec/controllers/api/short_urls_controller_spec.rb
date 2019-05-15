require 'rails_helper'

describe Api::ShortUrlsController, type: :controller do
  def generate_url(code)
    ShortUrl.create(email: "email@email.com", code: code, full_link: "http://www.google.com/")
  end

  def response_json
    @response_json ||= OpenStruct.new(JSON.parse(response.body))    
  end


  describe "GET #show" do
    describe "with valid code" do
      before(:each) do
        generate_url("abxde")
        get :show, params: { id: 'abxde' }        
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "returns full_link information" do
        expect(response_json.full_link).to eq("http://www.google.com/")
      end

      it "returns email information" do
        expect(response_json.email).to eq("email@email.com")
      end

    end

    describe "with invalid code" do
      before(:each) do
        get :show, params: { id: 'zzzzz' }
      end

      it "is successful" do
        expect(response).to be_success
      end

      it "returns an informative error" do        
        expect(response_json.errors.first).to match /Could not find short url/
      end
    end
  end

  describe "POST #create" do
    describe "with valid attributes" do
      before(:each) do
        @attrs = { email: "email@email.com", full_link: "http://www.google.com/" }
      end

      it "is successful" do        
        post :create, params: @attrs
        expect(response).to be_success
      end

      it "creates a new record" do
        expect{
          post(:create, params: @attrs)
        }.to change{ShortUrl.count}.by(1)
      end

      it "returns the shortened link" do        
        post :create, params: @attrs  
        code = ShortUrl.first.code
        expect(response_json.link).to match /#{code}/
      end

    end

    describe "with invalid attributes" do
      before(:each) do
        @attrs = { email: "abc", full_link: "xyz" }
      end

      it "is successful" do
        post :create, params: @attrs
        expect(response).to be_success
      end

      it "does not create a new record" do
        expect{
          post(:create, params: @attrs)
        }.to change{ShortUrl.count}.by(0)        
      end

      it "returns an informative error" do
        post :create, params: @attrs
        expect(response_json.errors.first).to match /is invalid/
      end     
    end    
  end
end