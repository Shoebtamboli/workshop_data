class ParticipantsController < ApplicationController
    def index
      @participants = Participant.all
    end
  
    def show
      @participant = Participant.find(params[:id])
    end
  
    def new
      @participant = Participant.new
    end
  
    def create
      @participant = Participant.new(participant_params)
      if @participant.save
        redirect_to @participant
      else
        render :new
      end
    end
  
    def edit
      @participant = Participant.find(params[:id])
    end
  
    def update
      @participant = Participant.find(params[:id])
      if @participant.update(participant_params)
        redirect_to @participant
      else
        render :edit
      end
    end
  
    def destroy
      @participant = Participant.find(params[:id])
      if @participant.destroy
        redirect_to participants_path, notice: 'Participant was successfully deleted.'
      else
        redirect_to participants_path, alert: 'Failed to delete the participant.'
      end
    end

    def send_feedback_link
      @participant = Participant.find(params[:id])
      
      # Optional: Destroy existing feedback link if it exists
      @participant.feedback_link&.destroy 
    
      @feedback_link = @participant.create_feedback_link!(
        expires_at: 2.weeks.from_now,
        token: SecureRandom.uuid
      )
      
      ParticipantMailer.send_feedback_link(@participant, @feedback_link).deliver_later
      
      redirect_to participants_path, notice: "We would appreciate your feedback on our workshop #{@participant.email}"
    end
    

    # def feedback_summary
    #     @participants = Participant.includes(:feedback_link)
    # end
  
    private
  
    def participant_params
      params.require(:participant).permit(:name, :email)
    end
  end