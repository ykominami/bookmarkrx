class PrevotesController < ApplicationController
  before_action :set_prevote, only: %i[ show edit update destroy ]

  # GET /prevotes or /prevotes.json
  def index
    @prevotes = Prevote.all
  end

  # GET /prevotes/1 or /prevotes/1.json
  def show
  end

  # GET /prevotes/new
  def new
    @prevote = Prevote.new
  end

  # GET /prevotes/1/edit
  def edit
  end

  # POST /prevotes or /prevotes.json
  def create
    @prevote = Prevote.new(prevote_params)

    respond_to do |format|
      if @prevote.save
        format.html { redirect_to prevote_url(@prevote), notice: "Prevote was successfully created." }
        format.json { render :show, status: :created, location: @prevote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prevote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prevotes/1 or /prevotes/1.json
  def update
    respond_to do |format|
      if @prevote.update(prevote_params)
        format.html { redirect_to prevote_url(@prevote), notice: "Prevote was successfully updated." }
        format.json { render :show, status: :ok, location: @prevote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prevote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prevotes/1 or /prevotes/1.json
  def destroy
    @prevote.destroy!

    respond_to do |format|
      format.html { redirect_to prevotes_url, notice: "Prevote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prevote
      @prevote = Prevote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prevote_params
      params.fetch(:prevote, {})
    end
end
