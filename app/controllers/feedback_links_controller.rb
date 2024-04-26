class FeedbackLinksController < ApplicationController
  before_action :set_participant

  def show
    @feedback_link = @participant.feedback_link
    if @feedback_link.nil? || @feedback_link.expires_at < Time.now
      redirect_to root_path, alert: 'Invalid or expired feedback link'
    elsif @feedback_link.feedback.present?
      redirect_to root_path, alert: 'You have already submitted your feedback'
    end
  end

  def update
    @feedback_link = @participant.feedback_link
    if @feedback_link.update(feedback_params)
      redirect_to root_path, notice: 'Thank you for your feedback.'
    else
      render :show
    end
  end

  private

  def set_participant
    @participant = Participant.find(params[:participant_id])
  end

  def feedback_params
    params.require(:feedback_link).permit(:feedback)
  end
end