require "rails_helper"

RSpec.describe TestMailer, type: :mailer do
  describe "testmailer" do
    let(:mail) { TestMailer.testmailer }

    it "renders the headers" do
      expect(mail.subject).to eq("Testmailer")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
