class CandidateController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  def index
    @candidates = Candidate.all
  end

  def show
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to @candidate
    else
      render 'new'
    end
  end

  def edit
     @candidate = Candidate.find(params[:id])
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to @candidate
    else
      render 'edit'
    end
  end

  def destroy
    @candidate.destroy
    redirect_to candidates_path
  end

  private
    def candidate_params
      params.require(:candidate).permit!
    end

    def set_candidate
      @candidate = Candidate.find(params[:id])
    end
end
