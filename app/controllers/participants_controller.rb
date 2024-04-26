class ParticipantsController < ApplicationController
    before_action :check_host_role, only: [:index,  :destroy]


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
      
      @participant.feedback_link&.destroy 
    
      @feedback_link = @participant.create_feedback_link!(
        expires_at: 2.weeks.from_now,
        token: SecureRandom.uuid
      )
      
      ParticipantMailer.send_feedback_link(@participant, @feedback_link).deliver_later
      
      redirect_to participants_path, notice: "We would appreciate your feedback on our workshop #{@participant.email}"
    end
    
    private
  
    def participant_params
      params.require(:participant).permit(:name, :email)
    end

    def check_host_role
      # Redirect to login page if no user is logged in
      unless user_signed_in?
        redirect_to new_user_session_path, alert: 'You must be logged in to access this page.'
        return
      end
  
      # Redirect to a safe page if the current user is not a host
      unless current_user.host?
        redirect_to participant_path(current_user), alert: 'You are not authorized to access this page.'
      end
    end
  end