class PathxcsController < ApplicationController
  before_action :set_pathx, only: %i[ show edit update destroy ]
  before_action :set_q, only: %i[search index]

  def index
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

  # search
  def search
    search_base(params[:frame_id])
  end

  private

  def search_base(frame_id)
    page = 1
    page = params[:page] if params[:page]
    @pathxss = @result.page(page)

    # @frame_id = "pathxs-list3"
    @frame_id = frame_id
    respond_to do |format|
      format.html { render "search" }
      format.json { head :no_content }
    end
  end

  def set_q
    @q = Pathx.ransack(params[:q])
    @q.sorts = "id desc" if @q.sorts.empty?
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
