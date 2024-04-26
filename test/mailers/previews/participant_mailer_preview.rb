# Preview all emails at http://localhost:3000/rails/mailers/participant_mailer
class ParticipantMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/participant_mailer/send_feedback_link
  def send_feedback_link
    ParticipantMailer.send_feedback_link
  end

end
