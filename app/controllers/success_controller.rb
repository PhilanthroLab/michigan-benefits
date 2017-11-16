class SuccessController < SnapStepsController
  def previous_path(*_args)
    nil
  end

  def next_path
    after_submit_path
  end

  private

  def before_rendering_edit_hook
    return if !current_application.exportable?

    ExportFactory.create(
      destination: :sms,
      snap_application: current_application,
    )

    ExportFactory.create(
      destination: :office_email,
      snap_application: current_application,
    )

    if web_driving_enabled?
      DriveApplicationJob.perform_later(snap_application: current_application)
    end
  end

  def web_driving_enabled?
    ENV.fetch("DRIVER_ENABLED", "false") == "true"
  end

  def update_application
    super

    flash[:notice] = flash_notice
    ExportFactory.create(
      destination: :client_email,
      snap_application: current_application,
    )
  end

  def flash_notice
    "Your application has been sent to your email inbox."
  end
end
