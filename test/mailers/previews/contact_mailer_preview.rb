# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
    def contact_us
        ContactMailer.contact_us(
            "John Barbosa", 
            "1234091655", 
            "john-brs@hotmail.com",
            "Esta es la descripcion de alguien que esta intentando contactarse con MEC"
            )
    end
end
