class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # # user must be logged in to edit
  # before_action :authenticate_user!, except: [:index, :show]
  # # only the author can edit his links
  # before_action :authorized_user, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def authorized_user
    # verify that current user is the author of the link
    @link = current_user.links.find_by(id: params[:id])
    redirect_to links_path, notice: "Not authorized to edit this link" if @link.nil?
  end

  # GET /links
  # GET /links.json
  def index
    @links = Link.order(cached_weighted_score: :desc)
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def upvote
    @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @link = Link.find(params[:id])
    @link.downvote_by current_user
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :content, :url, :cached_weighted_score)
    end
end
