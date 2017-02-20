class User < ApplicationRecord
	#for saving in db we change all addresses tu downcase;self means a current user
	before_save { self.email = self.email.downcase}
		
	#validation
	validates :name, presence: true , length: {maximum: 50}
	
	#regex exprssion made by Rubular.com
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true , length: {maximum: 256} ,
										 format: {with: VALID_EMAIL_REGEX} ,	
										 uniqueness: {case_sensitive: false}
	

end

