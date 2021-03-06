require 'rails_helper'

 RSpec.describe User, type: :model do

   describe 'User Validations' do

     it 'password and password_confirmation fields should match' do
       @user = User.new(name: 'Tofik',  email: 'Tofik@gmail.com', password: 'gmail', password_confirmation: 'gmail' )

       expect(@user.password).to eq(@user.password_confirmation)
     end

     it "does not register user if name is blank" do
       @user = User.new(name: nil,  email: 'Tofik@gmail.com', password: 'gmail', password_confirmation: 'gmail' )
       @user.save

       expect(User.where(email: 'Tofik@gmail.com').count) == 0
     end

     it "does not register user if email is blank" do
       @user = User.new(name: nil,  email: nil, password: 'gmail', password_confirmation: nil )
       @user.save

       expect(User.where(email: 'Tofik@gmail.com').count) == 0
     end

     it "does not register user if email already exist" do
       @user_1 = User.new(name: 'Tofik',  email: 'Tofik@gmail.com', password: 'gmail', password_confirmation: 'gmail' )
       @user_1.save

       @user_2 = User.new(name: 'Tofik',  email: 'Tofik@gmail.com', password: 'gmail', password_confirmation: 'gmail' )
       @user_2.save
       expect(User.where(email: 'Tofik@gmail.com').count) == 1
     end        


     it "does not register if password is less than 5 characters long" do
       @user = User.new(name: nil,  email: nil, password: '1234', password_confirmation: '1234' )
       @user.save

       expect(User.where(email: 'Tofik@gmail.com').count) == 0
     end

     it "can register if password is 5 characters long" do
       @user = User.new(name: nil,  email: nil, password: '12345', password_confirmation: '12345' )
       @user.save

       expect(User.where(email: 'Tofik@gmail.com').count) == 1
     end


   end

   describe '.authenticate_with_credentials' do

     it 'should authenticate users if credentials match' do
       user = User.new(name: 'Tofik',  email: 'Tofik@gmail.com', password: 'gmail', password_confirmation: 'gmail')
       user.save

       user_login = User.authenticate_with_credentials('Tofik@gmail.com', 'gmail')
       expect(user_login).to be_instance_of(User)
     end

     it 'should authenticate user if the email is in different cases' do
       user = User.new(name: 'Tofik',  email: 'Tofik@gmail.com', password: 'gmail', password_confirmation: 'gmail')
       user.save

       user_login = User.authenticate_with_credentials('Tofik@gmail.com', 'gmail')
       expect(user_login).to be_instance_of(User)
     end

     it 'should authenticate users if there is whitespace in the email address' do
       @user = User.new(name: 'Tofik',  email: 'Tofik@gmail.com', password: 'gmail', password_confirmation: 'gmail')
       @user.save

       expect(User.authenticate_with_credentials(' Tofik@gmail.com ', 'gmail')).to eq(@user)
     end

   end

 end