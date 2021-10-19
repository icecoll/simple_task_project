require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_length_of(:username).is_at_least(4).is_at_most(16) }

    it "should be invalid when username contains special character" do
      user = User.new(username: "fooo$")
      expect(user.valid?).to be_falsy
      expect(user.errors.where(:username).last.options[:messages]).to eq("only allows alphanumeric character")
    end

    it "should be valid when username only contains alphanumeric characters" do
      expect(User.new(username: "foo123").valid?).to be_truthy
    end
  end
end
