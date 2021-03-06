class WhoIsDisabledForm < Form
  set_attributes_for :application, :members
  set_attributes_for :member, :disabled

  validate :at_least_one_person_disabled

  def at_least_one_person_disabled
    return true if members.any?(&:disabled_yes?)
    errors.add(:members, "Make sure you select at least one person")
  end
end
