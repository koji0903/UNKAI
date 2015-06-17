class UnkaiPhotosController < ApplicationController
  before_action :set_unkai_photo, only: [:show, :edit, :update, :destroy]

  # GET /unkai_photos
  # GET /unkai_photos.json
  def index
#    @unkai_photos = UnkaiPhoto.all
    @unkai_photos = UnkaiPhoto.order("date")
  end

  # GET /unkai_photos/1
  # GET /unkai_photos/1.json
  def show
  end

  # GET /unkai_photos/new
  def new
    @unkai_photo = UnkaiPhoto.new
  end

  # GET /unkai_photos/1/edit
  def edit
  end

  # POST /unkai_photos
  # POST /unkai_photos.json
  def create
    @unkai_photo = UnkaiPhoto.new(unkai_photo_params)

    respond_to do |format|
      if @unkai_photo.save
        format.html { redirect_to @unkai_photo, notice: 'Unkai photo was successfully created.' }
        format.json { render :show, status: :created, location: @unkai_photo }
      else
        format.html { render :new }
        format.json { render json: @unkai_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unkai_photos/1
  # PATCH/PUT /unkai_photos/1.json
  def update
    respond_to do |format|
      if @unkai_photo.update(unkai_photo_params)
        format.html { redirect_to @unkai_photo, notice: 'Unkai photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @unkai_photo }
      else
        format.html { render :edit }
        format.json { render json: @unkai_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unkai_photos/1
  # DELETE /unkai_photos/1.json
  def destroy
    @unkai_photo.destroy
    respond_to do |format|
      format.html { redirect_to unkai_photos_url, notice: 'Unkai photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unkai_photo
      @unkai_photo = UnkaiPhoto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unkai_photo_params
      params.require(:unkai_photo).permit(:image, :image_cache, :remove_image, :comment, :date)
    end
end
