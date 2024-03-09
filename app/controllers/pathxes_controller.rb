class PathxesController < ApplicationController
  before_action :set_pathx, only: %i[ show edit update destroy look look2]
  before_action :set_q, only: [:look2, :searcha, :searchb, :index]

  # GET /pathxes or /pathxes.json
  def index

    # @pathxes = Pathx.all
    # @pathxes = Pathx.limit(19)
    @pathxes = Pathx.limit(100).page(params[:page])

    @hier = PathxesHelper::Hier.new()
    @hier.register_klass(Pathx)
    @pathxes.each do |pathx|
      @hier.add_path(pathx.path)
    end

    respond_to do |format|
      format.turbo_stream
      format.html
      format.json { render RootpathxComponent.new(name: "", hier: @hier, child_klass: NodepathxComponent) }
    end
  end

  # GET /pathxes/1 or /pathxes/1.json
  def show
    # render PathxComponent.new(proxy: @pathx, proxy_klass: BookmarkComponent)
  end

  # GET /pathxes/new
  def new
    @pathx = Pathx.new
  end

  # GET /pathxes/1/edit
  def edit
  end

  # POST /pathxes or /pathxes.json
  def create
    @pathx = Pathx.new(pathx_params)

    respond_to do |format|
      if @pathx.save
        format.html { redirect_to pathx_url(@pathx), notice: "Pathx was successfully created." }
        format.json { render :show, status: :created, location: @pathx }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pathx.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pathxes/1 or /pathxes/1.json
  def update
    respond_to do |format|
      if @pathx.update(pathx_params)
        format.html { redirect_to pathx_url(@pathx), notice: "Pathx was successfully updated." }
        format.json { render :show, status: :ok, location: @pathx }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pathx.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pathxes/1 or /pathxes/1.json
  def destroy
    @pathx.destroy

    respond_to do |format|
      format.html { redirect_to pathxes_url, notice: "Pathx was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # search
  def search_base(frame_id)
    page = 1
    page = params[:page] if params[:page]
    @pathxss = @result.page(page)

    # @frame_id = "pathxs-list3"
    @frame_id = frame_id
    respond_to do |format|
      format.html { render "searcha" }
      format.json { head :no_content }
    end
  end

  def searcha
    search_base("pathxs-list2")
  end

  def searchb
    search_base("pathxs-list3")
  end

  def look
  end

  def look2
    @q = Pathx.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @pathxs = @q.result.page(params[:page])
  end

  private

  def set_q
    @q = Pathx.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @result = @q.result(distince: true)
    # @result = params[:q]&.values&.reject(&blank?)

  end

  # Use callbacks to share common setup or constraints between actions.
  def set_pathx
    p params
    id_z = params[:idx]
    id_z = params[:id] if id_z == nil || id_z.strip.size == 0
    @pathx = Pathx.find(id_z)
  end

  # Only allow a list of trusted parameters through.
  def pathx_params
    # params.require(:pathx).permit(:idx, :path, :levle, :q, :button, :controller, :action)
    params.require(:pathx).permit(:path, :last_item)
  end
end
