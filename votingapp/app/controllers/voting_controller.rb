class VotingController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  def index
    @votes = Array.new
    Position.all.each do |x|
      postry = Vote.find_by(user_id: current_user.id, position_id: x.id)
      if postry != nil
        @votes << {position: postry.position_id, candidate: postry.candidate_id, comments: postry.comments}
      else
        @votes << {position: postry.position_id, candidate: -1, comments: ""}
        end
      end
    end
  end

  def show
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      flash[:notice] = "Vote successfully cast for \"#{Position.find_by(id: @vote.position_id).name}\" position!"
      redirect_to voting_index_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @vote.update(vote_params)
      flash[:notice] = "Vote successfully recast for \"#{Position.find_by(id: @vote.position_id).name}\" position!"
      redirect_to voting_index_path
    else
      render 'edit'
    end
  end

  def destroy
    @vote.update(candidate_id: 0, comments: "")
    flash[:notice] = "User abstains from voting for \"#{Position.find_by(id: @vote.position_id).name}\" position!"
    redirect_to voting_index_path
  end

  private
    def user_params
      params.require(:user).permit!
    end

    def vote_params
      params.require(:vote).permit!
    end

    def set_vote
      @vote = Vote.find(params[:id])
    end
end
