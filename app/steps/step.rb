class Step
  include ActiveModel::Model
  include ActiveModel::AttributeAssignment
  include ActiveModel::Validations::Callbacks

  class_attribute \
    :icon,
    :title,
    :headline,
    :subhead,
    :questions,
    :placeholders,
    :types,
    :section_headers

  def self.first
    IntroduceYourself
  end

  def self.find(id, app)
    id.gsub("-", "_").camelize.constantize.new(app)
  end

  def self.to_param
    self.name.underscore.dasherize
  end

  def initialize(app)
    self.questions ||= {}
    self.placeholders ||= {}
    self.types ||= {}
    self.section_headers ||= {}

    @app = app
    assign_from_app
  end

  def static_template
    nil
  end

  def to_param
    self.class.to_param
  end

  def update(params)
    assign_attributes(params)

    if valid?
      update_app!
    end
  end

  def placeholder(field)
    placeholders.fetch(field, "")
  end

  def type(field)
    types.fetch(field, :text)
  end

  def section_header(field)
    section_headers.fetch(field, nil)
  end

  def assign_from_app
    raise "Implement Me"
  end

  def update_app!
    raise "Implement Me"
  end
end
