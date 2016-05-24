class SurveydataController < ApplicationController
  before_action :set_surveydatum, only: [:show, :edit, :update, :destroy]

  # GET /surveydata
  # GET /surveydata.json
  def index
    @surveydata = Surveydatum.all
  end

  # GET /surveydata/1
  # GET /surveydata/1.json
  def show
  end

  # GET /surveydata/new
  def new
    @surveydatum = Surveydatum.new
  end

  # GET /surveydata/1/edit
  def edit
  end

  # POST /surveydata
  # POST /surveydata.json
  def create
    @surveydatum = Surveydatum.new(surveydatum_params)

    respond_to do |format|
      if @surveydatum.save
        format.html { redirect_to @surveydatum, notice: 'Surveydatum was successfully created.' }
        format.json { render :show, status: :created, location: @surveydatum }
      else
        format.html { render :new }
        format.json { render json: @surveydatum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveydata/1
  # PATCH/PUT /surveydata/1.json
  def update
    respond_to do |format|
      if @surveydatum.update(surveydatum_params)
        format.html { redirect_to @surveydatum, notice: 'Surveydatum was successfully updated.' }
        format.json { render :show, status: :ok, location: @surveydatum }
      else
        format.html { render :edit }
        format.json { render json: @surveydatum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveydata/1
  # DELETE /surveydata/1.json
  def destroy
    @surveydatum.destroy
    respond_to do |format|
      format.html { redirect_to surveydata_url, notice: 'Surveydatum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_surveydatum
      @surveydatum = Surveydatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def surveydatum_params
      params.require(:surveydatum).permit(:email, :surveyresponse, :reward)
    end
end
