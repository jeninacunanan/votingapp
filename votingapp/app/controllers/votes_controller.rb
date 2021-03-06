class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  def index
    @votes = Vote.where(user_id: current_user.id).order('position_id ASC')
  end

  def show
    @vote = Vote.find(params[:id])
    # require the ability to read votes
    authorize! :read, @vote
  end

  def new
    @pos_set = Position.except(Vote.find_by(user_id: current_user.id)[:position_id])
    if !@pos_set.nil?
      @vote = Vote.new
      @vote.user_id = current_user.id
    else
      flash[:alert] = "No more new positions to vote for!"
      redirect_to votes_path
    end
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id
    if @vote.save
      flash[:notice] = "Vote successfully cast for \"#{Position.find_by(id: @vote.position_id).name}\" position!"
      redirect_to votes_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @vote.update(vote_params)
      flash[:notice] = "Vote successfully recast for \"#{Position.find_by(id: @vote.position_id).name}\" position!"
      redirect_to votes_path
    else
      render 'edit'
    end
  end

  def destroy
    @vote.update(candidate_id: 0, comments: "")
    flash[:notice] = "User abstains from voting for \"#{Position.find_by(id: @vote.position_id).name}\" position!"
    redirect_to votes_path
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