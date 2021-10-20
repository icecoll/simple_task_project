require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_length_of(:username).is_at_least(4).is_at_most(16) }

    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_length_of(:password).is_at_least(8).is_at_most(16) }

    it "should be invalid when username contains special character" do
      user = User.new(username: "fooo$")
      expect(user.valid?).to be_falsy
      expect(user.errors.where(:username).last.options[:messages]).to eq("only allows alphanumeric character")
    end

    it "should be valid when username only contains alphanumeric characters" do
      user = User.new(username: "foo123")
      expect(user.errors.where(:username).present?).to be_falsy
    end

    it "should be invalid when password not contains upper case character" do
      user = User.new(password: "foo123")
      expect(user.valid?).to be_falsy
      expect(user.errors.where(:password).last.options[:messages]).to eq("should contains at least 1 upper case, 1 lower case, 1 number")
    end

    it "should be invalid when password not contains lower case character" do
      user = User.new(password: "FOO123")
      expect(user.valid?).to be_falsy
      expect(user.errors.where(:password).last.options[:messages]).to eq("should contains at least 1 upper case, 1 lower case, 1 number")
    end

    it "should be invalid when password not contains number" do
      user = User.new(password: "FOOoo")
      expect(user.valid?).to be_falsy
      expect(user.errors.where(:password).last.options[:messages]).to eq("should contains at least 1 upper case, 1 lower case, 1 number")
    end

    it "should be valid when password contains upper case, lower case and number" do
      user = User.new(password: "FOOoo1")
      expect(user.errors.where(:password).present?).to be_falsy
    end
  end

  describe "associations" do
    it { should have_many(:tasks) }
  end
end
