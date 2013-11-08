require 'base64'
require 'securerandom'

module Helpers
  def csrf_tag
    if session[:csrf]
      "<input type=\"hidden\" name=\"authenticity_token\" value=\"" + session[:csrf] + "\" />"
    else
      ""
    end
  end

  def escape(string)
    Rack::Utils.escape_html(string)
  end

  def normalize(string)
    string.split('_').map(&:capitalize).join(' ')
  end

  def random_string(bytes=32)
    SecureRandom.hex(bytes)
  end
end

class Sanitizer
  def self.escape(obj)
    case obj
    when Hash then escape_hash(obj)
    when Array then obj.map { |e| escape(e) }
    when String then escape_string(obj)
    else obj # e.g. numbers
    end
  end

  def self.escape_hash(obj)
    new = obj.dup
    new.each { |k, v| new[k] = escape(v) }
    new
  end

  def self.escape_string(obj)
    Rack::Utils.escape_html(obj)
  end
end
