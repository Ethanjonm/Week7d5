class User < ApplicationRecord
    validates :username, :session_token, uniqueness: true, presence: true 
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true }
    attr_reader :password

    before_validation :ensure_session_token

    has_many :posts,
        foreign_key: :user_id
        class_name: :Post

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            return user 
        else
            return nil 
        end

    end

    def is_password?(password)
        password_obj = BCrypt::Password.new(self.password_digest)
        password_obj.is_password?(password)

    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token
    end


    private

    def generate_unique_session_token
        session_token = SecureRandom::urlsafe_base64
        while User.exist?(session_token: session_token)
            session_token = SecureRandom::urlsafe_base64
        end
        return session_token
            
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

end
