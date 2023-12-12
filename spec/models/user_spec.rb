require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before(:each) do
      @user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )      
      @user.save
    end

    it 'should be created with password and password_confirmation fields' do
      expect(@user).to be_valid
    end

    it 'should not save if password and password_confirmation fields do not match' do
      @user.password_confirmation = 'mismatched_password'
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should require password and password_confirmation fields' do
      @user.password = nil
      @user.password_confirmation = nil
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation can't be blank")
    end  

    it 'should validate uniqueness of email (not case sensitive)' do
      @user.save
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      expect(duplicate_user).to_not be_valid
      expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
    end
    

    it 'should require email, first name, and last name' do
      @user.email = nil
      @user.first_name = nil
      @user.last_name = nil
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank", "First name can't be blank", "Last name can't be blank")
    end    
  end

  describe "Password minimum length" do
    before(:each) do
      @user = User.new(
        email: 'test@example.com',
        first_name: 'John',
        last_name: 'Doe',
        password: 'short', # Password length is less than the minimum required length
        password_confirmation: 'short'
      )
    end

    it 'should require a minimum password length' do
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
      @user.save
    end

    it 'should return user if authenticated' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'should return nil if not authenticated' do
      non_authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
      expect(non_authenticated_user).to be_nil
    end

    it 'should authenticate with email case insensitivity' do
      authenticated_user = User.authenticate_with_credentials('TEST@EXAMPLE.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'should authenticate with leading/trailing whitespace in email' do
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'should authenticate with wrong case in email' do
      authenticated_user = User.authenticate_with_credentials('TEST@EXAMPLE.CoM', 'password')
      expect(authenticated_user).to eq(@user)
    end
  end
end

