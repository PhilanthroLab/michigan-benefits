class HouseholdMoreInfo < Step
  self.title = "Your Household"
  self.subhead = "Tell us a bit more about your household."
  self.subhead_help = "These questions help us determine eligibility and could help you qualify for waivers to certain program rules."

  self.questions = {
    everyone_a_citizen: "Is each person a citizen?",
    anyone_disabled: "Does anyone have a disability?",
    any_new_moms: "Is anyone pregnant or has been pregnant recently?",
    any_medical_bill_help: "Does anyone need help paying for recent medical bills?",
    anyone_in_college: "Is anyone enrolled in college?",
    anyone_living_elsewhere: "Is anyone temporarily living outside the home?"
  }

  self.help_messages = {
    anyone_disabled: <<~HTML.html_safe,
      This includes physical, mental, or emotional health challenges.
      <br>
      <span class='label label--healthcare'>Healthcare</span>
    HTML
    any_new_moms: <<~HTML.html_safe,
      <span class='label label--healthcare'>Healthcare</span>
    HTML
    any_medical_bill_help: <<~HTML.html_safe,
      <span class='label label--healthcare'>Healthcare</span>
    HTML
    anyone_in_college: <<~HTML.html_safe,
      <span class='label label--healthcare'>Healthcare</span>
    HTML
    anyone_living_elsewhere: <<~HTML.html_safe,
      <span class='label label--healthcare'>Healthcare</span>
      +
      <span class='label label--food-assistance'>Food Assistance</span>
    HTML
  }

  self.types = {
    everyone_a_citizen: :yes_no,
    anyone_disabled: :yes_no,
    any_new_moms: :yes_no,
    any_medical_bill_help: :yes_no,
    anyone_in_college: :yes_no,
    anyone_living_elsewhere: :yes_no
  }

  attr_accessor \
    :everyone_a_citizen,
    :anyone_disabled,
    :any_new_moms,
    :any_medical_bill_help,
    :anyone_in_college,
    :anyone_living_elsewhere

  validates \
    :everyone_a_citizen,
    :anyone_disabled,
    :any_new_moms,
    :any_medical_bill_help,
    :anyone_in_college,
    :anyone_living_elsewhere,
    presence: { message: "Make sure to answer this question" }

  def previous
    HouseholdMembers.new(@app)
  end

  def next
    HouseholdSituations.new(@app)
  end

  def assign_from_app
    assign_attributes @app.attributes.slice(*%w[
      everyone_a_citizen
      anyone_disabled
      any_new_moms
      any_medical_bill_help
      anyone_in_college
      anyone_living_elsewhere
    ])
  end

  def update_app!
    @app.update!(
      everyone_a_citizen: everyone_a_citizen,
      anyone_disabled: anyone_disabled,
      any_new_moms: any_new_moms,
      any_medical_bill_help: any_medical_bill_help,
      anyone_in_college: anyone_in_college,
      anyone_living_elsewhere: anyone_living_elsewhere
    )
  end
end
