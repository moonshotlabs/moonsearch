require "data_mapper"
require 'dm-types'
#require 'dm-validations'
#
require "securerandom"
require "openssl"

class Freebie
  include DataMapper::Resource

  property :id,       Serial
  property :hashed,   String, :length => 64

  def self.generate!
    token = SecureRandom.hex(16)
    hash = OpenSSL::Digest::SHA256.hexdigest(token)
    freebie = self.create(:hashed => hash)
    if freebie.save
      return token
    else
      return "error"
    end
  end

  def self.exists?(token)
    hash = OpenSSL::Digest::SHA256.hexdigest(token)
    return first(:hashed => hash) != nil
  end

  def self.consume!(token)
    hash = OpenSSL::Digest::SHA256.hexdigest(token)
    freebie = first(:hashed => hash)
    if freebie
      freebie.destroy
    end
  end

end
