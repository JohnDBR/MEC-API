class ContactMailer < ApplicationMailer
    def contact_us(name, cc, email, description)
        # @url_helper = ApplicationController.default_url_options
        @name = name
        @cc = cc
        @description = description
        @email = email
		mail(from: email, to: "john-brs@hotmail.com", subject: 'MEC - Informacion de Contacto')
	end
end
