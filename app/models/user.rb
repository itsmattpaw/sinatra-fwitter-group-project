class User < ActiveRecord::Base
  include Slugs
  
  has_secure_password
  has_many :tweets
end
