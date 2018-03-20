require "rails_helper"

RSpec.describe AddHealthcareMemberForm do
  describe "validations" do
    it "requires first_name" do
      form = AddHealthcareMemberForm.new

      expect(form).not_to be_valid
      expect(form.errors[:first_name]).to be_present
    end

    it "requires last_name" do
      form = AddHealthcareMemberForm.new

      expect(form).not_to be_valid
      expect(form.errors[:last_name]).to be_present
    end

    it "does accept empty birthday" do
      form = AddHealthcareMemberForm.new(first_name: "Gary", last_name: "Tester")

      expect(form).to be_valid
      expect(form.errors[:birthday]).to_not be_present
    end

    it "does not accept invalid dates for birthday" do
      form = AddHealthcareMemberForm.new(birthday_year: 1992, birthday_month: 2, birthday_day: 30)

      expect(form).not_to be_valid
      expect(form.errors[:birthday]).to be_present
    end
  end
end
