class AccountValidator < ActiveModel::Validator
  include AccountHelper
  def validate(record)
  	@scanner = AccountDataScanner.new
    # Password.
    if @scanner.password(record.password) == false
      record.errors[:password] << "invalid"
    end
  end
end

class Account < ApplicationRecord
  has_many :blacklists, class_name: "Blacklist", foreign_key: "account_id", dependent: :destroy
  has_many :favorites, class_name: "Favorite", foreign_key: "account_id", dependent: :destroy
  has_many :followers, class_name: "Favorite", foreign_key: "user_id", dependent: :destroy
  
  include AccountHelper
  include ApplicationHelper
  include ActiveModel::Validations
  validates_with AccountValidator

  before_save do
    self.password = encrypt_password(self.password) if self.password_changed?
  end
  before_validation(on: :create) do
    self.sign_in_at = $datetime
    self.sign_up_at = self.sign_in_at
  end
  before_validation do
  	@normalizer = AccountNormalizer.new
  	self.username = @normalizer.username self.username if self.username_changed?
  	self.email = @normalizer.email self.email if self.email_changed?
  	self.password = @normalizer.password self.password if self.password_changed?
  	self.first_name = @normalizer.name self.first_name if self.first_name_changed?
  	self.last_name = @normalizer.name self.last_name if self.last_name_changed?
    self.first_name_ru = name_to_russian self.first_name
    self.last_name_ru = name_to_russian self.last_name
    self.first_name_en = name_to_english self.first_name
    self.last_name_en = name_to_english self.last_name
  	self.language = @normalizer.language self.language
  	unless self.new_record?
      self.is_active = @normalizer.is_active self.is_active if self.is_active_changed?
  	end
  end

  def check_password value
    @normalizer = AccountNormalizer.new
    return BCrypt::Password.new(self.password) == @normalizer.password(value)
  end

  validates :username,
      length: { minimum: 5, maximum: 36, too_short: "min", too_long: "max" },
      format: { with: AccountConfiguration.new.regexp[:username], message: "invalid" },
      uniqueness: { message: 'unique' }
  validates :first_name,
      length: { minimum: 1, maximum: 15, too_short: "min", too_long: "max" }
  validates :last_name,
      length: { minimum: 1, maximum: 15, too_short: "min", too_long: "max" }
  validates :email,
      length: { minimum: 5, maximum: 50, too_short: "min", too_long: "max" },
      format: { with: AccountConfiguration.new.regexp[:email], message: "invalid" },
      uniqueness: { message: 'unique' },
      allow_nil: true,
      allow_blank: false
  validates :gender,
      inclusion: { in: [0, 1], message: "invalid" }
  validates :password,
      length: { minimum: 6, maximum: 100, too_short: "min", too_long: "max" }

  def self.search input = nil, page = 1
    input = input.to_s.strip
    page = page.to_i
    page = 1 if page < 1

    scanner = AccountHelper::AccountDataScanner.new
    normalizer = AccountHelper::AccountNormalizer.new
    users = Array.new

    select_ = [:id, :username, :first_name, :last_name, :first_name_ru, :last_name_ru, :first_name_en, :last_name_en, :sign_in_at]
    order_ = {sign_in_at: :desc, id: :desc}
    where_ = {is_active: true}
    paginate_ = {:page => page, :per_page => 50}

    if input == ""
      # Select all users.
      users = Account.select(select_).order(order_).paginate(paginate_).where(where_)
    else
      if scanner.id(input)
        id = normalizer.id(input)
        user = Account.find_by(id: id, is_active: true) rescue nil
        unless user.nil?
          users.push user
        end
      else
        extend ApplicationHelper
        names = split_string(input)
        if names.size == 1
          username = normalizer.username(names[0])
          name = normalizer.name(names[0])
          users = Account.select(select_).order(order_).paginate(paginate_).where(where_).where(
            "(
            username = ? OR
            first_name = ? OR first_name_ru = ? OR first_name_en = ? OR
            last_name = ? OR last_name_ru = ? OR last_name_en = ?
            )",
            username,
            name, name,
            name, name,
            name, name
          ).all
        elsif names.size >= 2
          names_ = Array.new
          names.each do |name|
            names_.push(normalizer.name(name))
          end
          users = Account.select(select_).order(order_).paginate(paginate_).where(where_).where(
            "(
            (first_name IN (?) OR first_name_ru IN (?) OR first_name_en IN (?)) AND
            (last_name IN (?) OR last_name_ru IN (?) OR last_name_en IN (?))
            )",
            names_, names_, names_,
            names_, names_, names_
          ).all
        end
      end
    end
    return users
  end
  def self.profile input
    scanner = AccountHelper::AccountDataScanner.new
    normalizer = AccountHelper::AccountNormalizer.new

    if scanner.id(input)
      input = normalizer.id(input)
      user = Account.where("id = ?", input).first
    else
      input = normalizer.username(input)
      user = Account.where("username = ?", input).first
    end
    unless user.nil?
      if user.is_active == true
        return {
          :is_active => user.is_active,
          :id => user.id,
          :username => user.username,
          :first_name => user.first_name,
          :first_name_ru => user.first_name_ru,
          :first_name_en => user.first_name_en,
          :last_name => user.last_name,
          :last_name_ru => user.last_name_ru,
          :last_name_en => user.last_name_en,
          :gender => user.gender,
          :country => user.country,
          :city => user.city,
          :sign_in_at => user.sign_in_at,
          :sign_up_at => user.sign_up_at
        }
      else
        # User is deleted.
        return {
          :is_active => user.is_active,
          :id => user.id,
          :username => user.username,
        }
      end
    end
    return nil
  end
end
