# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before(:each) do
  	@attr = { :name => "Example User", :email => "user@example.com" }
  end

  it "should create a new instance given valid attributes" do
  	User.create!(@attr)
  end

  it "should require a name" do
  	no_name_user = User.new(@attr.merge(:name => ""))
  	no_name_user.should_not be_valid
  end

  it "should require an email address" do
  	no_email_user = User.new(@attr.merge(:email => ""))
  	no_email_user.should_not be_valid
  end

  it "should not reject name that are too long" do
  	long_name = "a" * 51
  	long_name_user = User.new(@attr.merge(:name => long_name))
  	long_name_user.should_not be_valid
  end

  it "should accept valid email address" do 
  	addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
  	addresses.each do |address|
  		valid_mail_user = User.new(@attr.merge(:email => address))
  		valid_mail_user.should be_valid
  	end
  end

  it "should reject invalid email address" do 
  	addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
  	addresses.each do |address|
  		valid_mail_user = User.new(@attr.merge(:email => address))
  		valid_mail_user.should_not be_valid
  	end
  end

  it "should reject duplicate email address" do
  	User.create!(@attr)
  	user_with_duplicate_email = User.new(@attr)
  	user_with_duplicate_email.should_not be_valid
  end
end