class HierxesController < ApplicationController
  before_action :set_hierx, only: %i[ show edit update destroy ]

  # GET /hierxes or /hierxes.json
  def index
    @hierxes = Hierx.all
  end

  # GET /hierxes/1 or /hierxes/1.json
  def show
  end

  # GET /hierxes/new
  def new
    @hierx = Hierx.new
  end

  # GET /hierxes/1/edit
  def edit
  end

  # POST /hierxes or /hierxes.json
  def create
    @hierx = Hierx.new(hierx_params)

    respond_to do |format|
      if @hierx.save
        format.html { redirect_to hierx_url(@hierx), notice: "Hierx was successfully created." }
        format.json { render :show, status: :created, location: @hierx }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hierx.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hierxes/1 or /hierxes/1.json
  def update
    respond_to do |format|
      if @hierx.update(hierx_params)
        format.html { redirect_to hierx_url(@hierx), notice: "Hierx was successfully updated." }
        format.json { render :show, status: :ok, location: @hierx }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hierx.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hierxes/1 or /hierxes/1.json
  def destroy
    @hierx.destroy

    respond_to do |format|
      format.html { redirect_to hierxes_url, notice: "Hierx was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hierx
      @hierx = Hierx.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hierx_params
      params.require(:hierx).permit(:parent_id, :child_id, :generation)
    end
end
