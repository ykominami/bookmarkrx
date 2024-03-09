class ChoiceproposalsController < ApplicationController
  before_action :set_choiceproposal, only: %i[ show edit update destroy ]

  # GET /choiceproposals or /choiceproposals.json
  def index
    @choiceproposals = Choiceproposal.all
  end

  # GET /choiceproposals/1 or /choiceproposals/1.json
  def show
  end

  # GET /choiceproposals/new
  def new
    @choiceproposal = Choiceproposal.new
  end

  # GET /choiceproposals/1/edit
  def edit
  end

  # POST /choiceproposals or /choiceproposals.json
  def create
    @choiceproposal = Choiceproposal.new(choiceproposal_params)

    respond_to do |format|
      if @choiceproposal.save
        format.html { redirect_to choiceproposal_url(@choiceproposal), notice: "Choiceproposal was successfully created." }
        format.json { render :show, status: :created, location: @choiceproposal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @choiceproposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /choiceproposals/1 or /choiceproposals/1.json
  def update
    respond_to do |format|
      if @choiceproposal.update(choiceproposal_params)
        format.html { redirect_to choiceproposal_url(@choiceproposal), notice: "Choiceproposal was successfully updated." }
        format.json { render :show, status: :ok, location: @choiceproposal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @choiceproposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /choiceproposals/1 or /choiceproposals/1.json
  def destroy
    @choiceproposal.destroy!

    respond_to do |format|
      format.html { redirect_to choiceproposals_url, notice: "Choiceproposal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_choiceproposal
      @choiceproposal = Choiceproposal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def choiceproposal_params
      params.require(:choiceproposal).permit(:content, :status)
    end
end
