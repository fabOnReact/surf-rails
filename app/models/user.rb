class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
	def google_oauth2
		@user = User.from_omniauth(request.env['omniauth.auth'])

		if @user.persisted?
			flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
			sign_in_and_redirect @user, event: :authentication
		else
			session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
			redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
		end
	end		
	def self.from_omniauth(access_token)
	    data = access_token.info
	    user = User.where(email: data['email']).first

	    # Uncomment the section below if you want users to be created if they don't exist
	    unless user
	        user = User.create(name: data['name'],
	           email: data['email'],
	           password: Devise.friendly_token[0,20]
	           )
	    end
	    user
	end
end
