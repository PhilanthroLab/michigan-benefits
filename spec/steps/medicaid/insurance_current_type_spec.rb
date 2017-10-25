require "rails_helper"

RSpec.describe Medicaid::InsuranceCurrentType do
  describe "Validations" do
    context "each insured household member has an insurance type" do
      it "is valid" do
        member = create(:member,
                        is_insured: true,
                        insurance_type: "Medicaid")

        member_without_insurance = create(:member,
                                          is_insured: false,
                                          insurance_type: nil)

        step = Medicaid::InsuranceCurrentType.new(
          members: [member, member_without_insurance],
        )

        expect(step).to be_valid
      end
    end

    context "an insured household member is missing an insurance type" do
      it "is invalid" do
        member = create(:member,
                        is_insured: true,
                        insurance_type: "Medicaid")

        insured_member_without_type = create(:member,
                                             is_insured: true,
                                             insurance_type: nil)

        step = Medicaid::InsuranceCurrentType.new(
          members: [member, insured_member_without_type],
        )

        expect(step).not_to be_valid
      end
    end
  end

  describe "#insured_members_needing_insurance" do
    context "with insured members needing insurance" do
      it "returns only insured members needing insurance" do
        insured_member = create(:member,
                                is_insured: true,
                                requesting_health_insurance: true)

        abstaining_member = create(:member,
                                   is_insured: true,
                                   requesting_health_insurance: false)

        uninsured_member = create(:member,
                                  is_insured: false,
                                  requesting_health_insurance: true)

        step = Medicaid::InsuranceCurrentType.new(
          members: [
            insured_member,
            abstaining_member,
            uninsured_member,
          ],
        )

        expect(step.insured_members_requesting_insurance).to eq(
          [insured_member],
        )
      end
    end

    context "with insured members not needing insurance" do
      it "returns an empty array" do
        insured_member = create(:member,
                                is_insured: true,
                                requesting_health_insurance: false)

        uninsured_member = create(:member,
                                  is_insured: false,
                                  requesting_health_insurance: true)

        step = Medicaid::InsuranceCurrentType.new(
          members: [insured_member, uninsured_member],
        )

        expect(step.insured_members_requesting_insurance).to eq([])
      end
    end

    context "without insured members" do
      it "returns an empty array" do
        step = Medicaid::InsuranceCurrentType.new(
          members: create_list(:member, 2,
                               is_insured: false,
                               requesting_health_insurance: true),
        )

        expect(step.insured_members_requesting_insurance).to eq([])
      end
    end
  end
end
