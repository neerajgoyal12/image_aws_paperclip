class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    
    # if(params[:url])
#     @photo = Photo.new
#     render "new" and return
#     end
 
    if(params[:photo][:ulr])
        puts params[:photo][:ulr]
        @photo = Photo.new(photo_params)
        respond_to do |format|
         if @photo.save
            #we want a destination(paperclip_file_path) and a source(raw_source)
            # paperclip_file_path = "raffles/attached_files/#{@raffle.id}/original/#{params[:raffle][:attached_file_file_name]}"
            # raw_source = params[:raffle][:attached_file_file_path]
            
            # Raffle.copy_and_delete paperclip_file_path, raw_source #this is where we call a method to copy from temp location to where paperclip expects it to be.
            format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
            format.json { render action: 'show', status: :created, location: @photo }
          else
            format.html { render action: 'new' }
            format.json { render json: @photo.errors, status: :unprocessable_entity }
          end
        end
      else
        @photo = Photo.new
        render action: 'new', notice: "No file"
    end
  end
  # def create
  #   @photo = Photo.new(photo_params)

  #   respond_to do |format|
  #     if @photo.save
  #       format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
  #       format.json { render :show, status: :created, location: @photo }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @photo.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :user_id)
    end
end
