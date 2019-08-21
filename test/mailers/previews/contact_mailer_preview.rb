# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
    def contact_us
        ContactMailer.contact_us(
            "Adrian perez", 
            "44442315633", 
            "comercial@mec.com.co",
            "Esta es la descripcion de alguien que esta intentando contactarse con MEC"
            )
    end
end
