module Integrated
  class WhoIsStudentController < MultipleMembersController
    def self.skip?(application)
      return true if application.single_member_household?
      !application.navigator.anyone_student?
    end
  end
end
