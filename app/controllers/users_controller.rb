class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    authorize
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    respond_to do |format|
      format.html { render "users/_form2", locals: { user: @user } }
      format.json { render :show, status: :created, location: @user }
    end
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(user_in_session.id)

    upload_file = params[:user][:upload_file]
    if upload_file.present?
      upload_file_name = upload_file.original_filename
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def sign_in
    @user = User.new
    # render layout: 'application_signed_out'
    render "sign_in"
  end

  def sign_up
    @user = User.new
    # render layout: 'application_signed_out'
    render "sign_up"
  end

  def sign_in_process
    p user_params
    p user_params[:user]
    # @user = User.new( {name: params[:name], email: params[:email], password: params[:password] })
    # @user = User.new( params[:user] )
    @user = User.new(user_params)
    encrypted_password = User.generate_digest(params[:user][:password])
    user = User.find_by(email: params[:email], password: encrypted_password)
    if user
      user_session_start(user)
      redirect_to top_path and return
    else
      flash.now[:digest] = "Can not signin"
      # render :sign_in, layout: "application_signed_out" and return
      redirect_to top_path and return
      # render "pages/top"
    end
  end

  def sign_up_process
    @user = User.new(user_params)
    if @user.save
      user_session_start(@user)
      flash.now[:session] = "registered"
      redirect_to top_path and return
    else
      flash.now[:danger] = @user.errors.messages.values.flattern.join("<br>")
      render :sign_up, lauout: "application_signed_out" and return
    end
  end

  def sign_out
    user_session_end
    redirect_to :sign_in and return
  end

  def permitted_params
    [user: user_params]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :image_file_name, :email, :password)
  end
end
