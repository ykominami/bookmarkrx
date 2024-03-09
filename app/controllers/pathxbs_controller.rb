class PathxbsController < ApplicationController
  before_action :set_pathxb, only: %i[ show edit update destroy]

  # GET /pathxbs or /pathxbs.json
  def index
    @pathxbs = Pathx.page(params[:page])
    @search = Pathx.ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @pathxbs = @search.result.page(params[:page])

    respond_to do |format|
      format.turbo_stream
      format.html
      format.json 
    end
  end

  # GET /pathxbs/1 or /pathxbs/1.json
  def show
  end

  # GET /pathxbs/new
  def new
    @pathxb = pathxb.new
  end

  # GET /pathxbs/1/edit
  def edit
  end

  # POST /pathxbs or /pathxbs.json
  def create
    @pathxb = pathxb.new(pathxb_params)

    respond_to do |format|
      if @pathxb.save
        format.html { redirect_to pathxb_url(@pathxb), notice: "pathxb was successfully created." }
        format.json { render :show, status: :created, location: @pathxb }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pathxb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pathxbs/1 or /pathxbs/1.json
  def update
    respond_to do |format|
      if @pathxb.update(pathxb_params)
        format.html { redirect_to pathxb_url(@pathxb), notice: "pathxb was successfully updated." }
        format.json { render :show, status: :ok, location: @pathxb }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pathxb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pathxbs/1 or /pathxbs/1.json
  def destroy
    @pathxb.destroy

    respond_to do |format|
      format.html { redirect_to pathxbs_url, notice: "pathxb was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pathxb
    p params
    id_z = params[:idx]
    id_z = params[:id] if id_z == nil || id_z.strip.size == 0
    @pathxb = pathxb.find(id_z)
  end

  # Only allow a list of trusted parameters through.
  def pathxb_params
    params.require(:pathxb).permit(:idx, :path, :level)
  end
end
