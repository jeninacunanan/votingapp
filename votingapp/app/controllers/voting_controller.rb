class VotingController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  
  
  def index
    @votes = Vote.where(user_id: current_user.id)
    @candidates = Candidate.all
    @positions = Position.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit!
    end

    def set_vote
      @vote = Vote.find(params[:id])
    end
end
