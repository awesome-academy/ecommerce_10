require "rails_helper"
require "pry"

RSpec.describe User, type: :model do
    let(:user) {User.new(name: Faker::Name.name,
                         email: "phanthanhdong14@gmail.com",
                         password: "123456789",
                         password_confirmation: "123456789")}

  context ".validation" do
    it "should be valid" do
      expect(user).to be_valid
    end
    it "name should be present" do
      user.name = " "
      expect(user).to_not be_valid
      user.save
      expect(user.errors.messages).to include(name: including(I18n.t("errors.messages.blank")))
    end
    it "email should be present" do
      record = User.new
      record.email = user.email
      record.valid?
      record.errors[:email].should_not include("can't be blank")
      record.email = " "
      record.valid?
      record.errors[:email].should include("can't be blank")
    end
    it "email addresses should be unique" do
      duplicate_user = user.dup
      duplicate_user.email = user.email
      user.save
      expect(duplicate_user).to_not be_valid
      duplicate_user.save
      expect(duplicate_user.errors.messages).to include(email: including(I18n.t("errors.messages.taken")))
    end
    it "email reject invalid addresses" do
      invalid_addresses = %w(user_at_foo.org user.name@example.
        foo@bar_baz.com foo@bar+baz.com poem@gmail.com23)
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to_not be_valid
      end
      user.save
      expect(user.errors.messages).to include(email: including(I18n.t("errors.messages.invalid")))
    end
    it "password should be present" do
      user.password = user.password_confirmation = " "
      expect(user).to_not be_valid
      user.save
      expect(user.errors.messages).to include(password: including(I18n.t("errors.messages.blank")))
    end
    it "confirmation password should be true" do
      user.password = "123456"
      user.password_confirmation = "654321"
      expect(user).to_not be_valid
      user.save
      expect(user.errors.messages).to include(password_confirmation: including(
        I18n.t("errors.messages.confirmation", attribute: "Password")))
    end
  end

  context ".associations" do
    it "should have many orders" do
      t = User.reflect_on_association(:orders)
      expect(t.macro).to eq(:has_many)
    end
    it "should have many comments" do
      t = User.reflect_on_association(:comments)
      expect(t.macro).to eq(:has_many)
    end
  end
end
