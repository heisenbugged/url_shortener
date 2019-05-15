require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe "#generate_code" do
    it "generates a distinct code" do
      short_code_1 = ShortUrl.new
      short_code_1.generate_code
      short_code_2 = ShortUrl.new
      short_code_2.generate_code

      expect(short_code_1.code === short_code_2.code).to be_falsey
    end
  end
end
