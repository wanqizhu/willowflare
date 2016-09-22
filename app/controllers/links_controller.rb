class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # user must be logged in to edit
  before_action :authenticate_user!, except: [:index, :show]
  # only the author can edit his links
  before_action :authorized_user, only: [:edit, :update, :destroy]

  def authorized_user
    # skip authentication if you are an admin 
    if current_user.auth_level < 90
      # verify that current user is the author of the link
      @link = current_user.links.find_by(id: params[:id])
      redirect_to links_path, notice: "Not authorized to edit this link" if @link.nil?
    end
  end

  # GET /links
  # GET /links.json
  def index
    unless user_signed_in?
      redirect_to '/home' # go to new landing page if not signed in
    end
    
    @links = Link.order(updated_at: :desc) # use cached_weighted_score for sorting by votes
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
    # if content starts with _, then we update the link WITHOUT updating its 'updated_at' attribute
    if !link_params["content"].blank? and link_params["content"][0] == '_'
      link_params2 = link_params
      link_params2["content"] = link_params["content"][1..-1]
      
      # this does the same thing as @link.update, except it skips validation, callbacks, and updated_at/updated_on
      respond_to do |format|
        if @link.update_columns(link_params2)
          format.html { redirect_to @link, notice: 'Review was successfully updated w/o changing updated_at time.' }
          format.json { render :show, status: :ok, location: @link }
        else
          format.html { render :edit }
          format.json { render json: @link.errors, status: :unprocessable_entity }
        end
      end

    else
    
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
      params.require(:link).permit(:title, :content, :url, :img, :cached_weighted_score)
    end
end
