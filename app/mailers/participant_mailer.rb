class ParticipantMailer < ApplicationMailer
  default from: 'your_email_address@example.com'

  def send_feedback_link(participant, feedback_link)
    @participant = participant
    @feedback_link = feedback_link

    # Construct the URL with the participant ID and feedback link token
    @feedback_link_url = participant_feedback_link_url(@participant, @feedback_link, token: @feedback_link.token, host: 'localhost:3000')

    mail(to: @participant.email, subject: 'Workshop Feedback')
  end
end