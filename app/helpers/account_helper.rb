module AccountHelper
  class AccountConfiguration
    attr_reader :default, :languages, :regexp
    def initialize
        @default = {
            :language => 'en'
        }
        @languages = ['kk', 'ru', 'en']
        @regexp = {
            :username => /
            (?!(^[\d]+$)) # excludes.
            \A(
                (
                    ([a-z\d]+)
                    (
                        ([\._-])?
                        ([a-z\d]+)
                    )+
                )
            )\z
            /x,
            :email => /
            \A(
                ([a-z\d\._-]+)
                @
                ([a-z\d\._-]+)
            )\z
            /x
        }
    end
  end
  class AccountNormalizer
    attr_reader :config
    def initialize
        @config = AccountConfiguration.new
    end
    def username value
        value.to_s.strip.downcase
    end
    def first_name value
        value.to_s.strip.gsub(' ', '').capitalize
    end
    def last_name value
        self.first_name value
    end
    def gender value
        value = value.to_s.strip
        if value == "0"
          return 0
        elsif value == "1"
          return 1
        else
          return nil
        end
    end
    def email value
        value = value.to_s.strip.downcase
        if value == ""
            return nil
        else
            return value
        end
    end
    def password value
        value.to_s.strip
    end
    def language value
        value = @config.languages.include?(value) ? value : @config.default[:language]
    end
    def is_active value
    	value = value.to_s.strip
    	if value == "1" || value == "true"
    		return true
		else
			return false
		end
    end
  end
  class AccountDataScanner
  	attr_reader :config
    def initialize
        @config = AccountConfiguration.new
        @normalizer = AccountNormalizer.new
    end
    def username value
    	value = @normalizer.username(value)
    	return value.match(@config.regexp[:username]) != nil
    end
    def email value
    	value = @normalizer.email(value)
    	return value.match(@config.regexp[:email]) != nil
    end
    def password value
    	value = @normalizer.password(value)
    	if value.ascii_only? == true
    		return true
    	end
    	return false
    end
    def gender value
    	value = @normalizer.gender(value)
    	unless value == nil
    		return true
    	end
    	return false
    end
  end
  def init_account
    @current_user = Account.find(session[:account_id]) rescue nil
    @is_auth = false
    unless @current_user.nil?
        @is_auth = true
    end
  end
  def login account
    begin
        session[:account_id] = account.id
        return true
    rescue
        return false
    end
  end
  def logout
    begin
        session.delete(:account_id)
        return true
    rescue
        return false
    end
  end
  def encrypt_password value
    @normalizer = AccountNormalizer.new
    return BCrypt::Password.create(@normalizer.password(value)).to_s
  end
end
