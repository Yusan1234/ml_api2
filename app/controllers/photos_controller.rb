class PhotosController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  require 'rubygems'
  require 'RMagick'
  def new
    @photo = Photo.new
    @DevImg = Photo.where(name: 'dev')
    gon.img = @DevImg
  end
  def index
    image_file = File.open("public/uploads/photo/image/dancing.jpg")
    styled_file = File.open("public/uploads/photo/image/dancing.jpg")
    base64_image = Base64.strict_encode64(image_file.read)
    base64_image_style = Base64.strict_encode64(styled_file.read)
    data = [
      ["content_img", base64_image],
      ['style_img',  base64_image_style]
    ].to_json
    # req.set_form(data, "multipart/form-data")

    uri = URI.parse("http://0.0.0.0:8888/predict")
    req = Net::HTTP.new(uri.host, uri.port)
    req.post(uri.path, data)
  end
  def create
    @photo = Photo.new
     uploader = ImageUploader.new
     if uploader.store!(params[:photo][:image])
      @photo.image = uploader
      @photo.save
      flash[:success] = "Post created!"
      redirect_to action: :index
    end
  end
  
  private
    def photos_params
      params.require(:photo).permit(:image)
    end
end
