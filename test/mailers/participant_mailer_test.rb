require "test_helper"

class ParticipantMailerTest < ActionMailer::TestCase
  test "send_feedback_link" do
    mail = ParticipantMailer.send_feedback_link
    assert_equal "Send feedback link", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
