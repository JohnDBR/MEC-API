class User < ApplicationRecord
    has_secure_password

    validates :username, :password, :emails, :phones, :address, presence: true, on: :create

    before_save :format_downcase

    protected
    def format_downcase
        self.username.downcase! if self.username
    end
end
