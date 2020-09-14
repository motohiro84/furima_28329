class MyMailer < Devise::Mailer
  def reset_password_instructions(record, token, opts = {})
    super(record, token, opts.merge(default_opts))
  end

  def reset_password_instructions(record, token, opts = {})
    super(record, token, opts.merge(default_opts))
  end

  def unlock_instructions(record, token, opts = {})
    super(record, token, opts.merge(default_opts))
  end

  def default_opts
    {
      bcc: Settings.mail[:bcc]
    }
  end
end
