require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome_email," do
    let(:mail) { UserMailer.welcome_email, }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome email,")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "forgot_password_email" do
    let(:mail) { UserMailer.forgot_password_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Forgot password email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end