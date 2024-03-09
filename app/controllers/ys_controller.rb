class YsController < ApplicationController
  before_action :set_y, only: %i[ show edit update destroy ]

  # GET /ys or /ys.json
  def index
    @ys = Y.all
  end

  # GET /ys/1 or /ys/1.json
  def show
  end

  # GET /ys/new
  def new
    @y = Y.new
  end

  # GET /ys/1/edit
  def edit
  end

  # POST /ys or /ys.json
  def create
    @y = Y.new(y_params)

    respond_to do |format|
      if @y.save
        format.html { redirect_to y_url(@y), notice: "Y was successfully created." }
        format.json { render :show, status: :created, location: @y }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @y.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ys/1 or /ys/1.json
  def update
    respond_to do |format|
      if @y.update(y_params)
        format.html { redirect_to y_url(@y), notice: "Y was successfully updated." }
        format.json { render :show, status: :ok, location: @y }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @y.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ys/1 or /ys/1.json
  def destroy
    @y.destroy!

    respond_to do |format|
      format.html { redirect_to ys_url, notice: "Y was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_y
      @y = Y.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def y_params
      params.require(:y).permit(:name)
    end
end
