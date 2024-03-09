class ProposersController < ApplicationController
  before_action :set_proposer, only: %i[ show edit update destroy ]

  # GET /proposers or /proposers.json
  def index
    @proposers = Proposer.all
  end

  # GET /proposers/1 or /proposers/1.json
  def show
  end

  # GET /proposers/new
  def new
    @proposer = Proposer.new
  end

  # GET /proposers/1/edit
  def edit
  end

  # POST /proposers or /proposers.json
  def create
    @proposer = Proposer.new(proposer_params)

    respond_to do |format|
      if @proposer.save
        format.html { redirect_to proposer_url(@proposer), notice: "Proposer was successfully created." }
        format.json { render :show, status: :created, location: @proposer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @proposer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proposers/1 or /proposers/1.json
  def update
    respond_to do |format|
      if @proposer.update(proposer_params)
        format.html { redirect_to proposer_url(@proposer), notice: "Proposer was successfully updated." }
        format.json { render :show, status: :ok, location: @proposer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @proposer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proposers/1 or /proposers/1.json
  def destroy
    @proposer.destroy!

    respond_to do |format|
      format.html { redirect_to proposers_url, notice: "Proposer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposer
      @proposer = Proposer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def proposer_params
      params.require(:proposer).permit(:name, :session)
    end
end
