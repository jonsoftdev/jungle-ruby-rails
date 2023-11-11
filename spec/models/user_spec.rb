require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    before do
      @user = User.create({first_name: "John", last_name: "Doe", email: "john@gmail.com", password: "123456", password_confirmation: "123456"})
end

it 'must be created with a password and password_confirmation fields' do 
  @user.password = nil
  @user.password_confirmation = nil
  expect(@user).to_not be_valid
end

it 'must have matching password and password_confirmation fields' do
  @user.password_confirmation = "1234567"
  expect(@user).to_not be_valid

  it "is not valid without a first name" do
    user = User.new(first_name: nil)
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("First name can't be blank")
  end

  it "is not valid without a last name" do
    user = User.new(last_name: nil)
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("Last name can't be blank")
  end

  it "is not valid without an email" do
    user = User.new(email: nil)
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("Email can't be blank")
  end
  it "is not valid when email is not unique" do
    user = User.new(email: "john@gmail.com")
    expect(user).to_not be_valid
    expect(user.errors.full_messages).to include("Email has already been taken")
    end
    it "is not valid when password is less than 6 characters" do
      user = User.new(password: "1234")
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
end
describe '.authenticate_with_credentials' do
  
  before do
    @user = User.create(first_name:'John', last_name:'Doe', email:'john@gmail.com', password:'123456', password_confirmation:'123456')
end

it 'is valid when email and password match' do
  auth_user = User.authenticate_with_credentials('john@gmail.com', '123456')
  expect(auth_user).to eq(@user)
  end

  it 'is not valid when email and password do not match' do
    auth_user = User.authenticate_with_credentials('john@gmail.com', '1234567')
    expect(auth_user).to_not eq(@user)
  end

  it 'is valid when email has spaces before and/or after' do
    auth_user = User.authenticate_with_credentials('john@gmail.com', '123456')
    expect(auth_user).to eq(@user)
  end

  it 'is valid when email is typed in the wrong case' do
    auth_user = User.authenticate_with_credentials('john@gmail.com', '123456')
    expect(auth_user).to eq(@user)
  end
end
end