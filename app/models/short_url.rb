class ShortUrl < ApplicationRecord
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP
  validates :code, presence: true, uniqueness: :true
  validates :full_link, presence: :true, format: URI::Parser.new.make_regexp(['http', 'https'])

  def self.generate(params)
    short_url = ShortUrl.find_by_full_link_and_email(params[:full_link], params[:email])
    short_url ||= ShortUrl.new(params)
    short_url.generate_code if short_url.code.blank?
    return short_url
  end

  def generate_code
    self.code = ('a'..'z').to_a.shuffle[0,5].join
    generate_code if ShortUrl.find_by_code(self.code)
    return self.code
  end
end
