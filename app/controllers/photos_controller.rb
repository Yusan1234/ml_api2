class PhotosController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  require 'rubygems'
  require 'RMagick'
  require 'timeout'

  def new
    @photo = Photo.new
    @DevImg = Photo.where(name: 'dev')
    gon.img = @DevImg
  end

  def index
  begin
    Timeout.timeout(30000) do
      image_file = File.open("public/uploads/photo/image/dancing.jpg")
      styled_file = File.open("public/uploads/photo/image/dancing.jpg")
      base64_image = Base64.strict_encode64(image_file.read)
      base64_image_style = Base64.strict_encode64(styled_file.read)
      uri = URI.parse("http://0.0.0.0:8888/predict")
      https = Net::HTTP.new(uri.host, uri.port)
       
      # https.use_ssl = true # HTTPSでよろしく
      req = Net::HTTP::Post.new(uri.request_uri)
       
      req["Content-Type"] = "application/json" # httpリクエストヘッダの追加
      payload = {
        "content_img" => base64_image,
           "style_img" => base64_image_style
      }.to_json
      req.body = payload # リクエストボデーにJSONをセット
      res = https.request(req)
      # 返却の中身を見てみる
      puts res.code
      puts res.message
      puts res.body
    end
  end
  rescue Timeout::Error
    puts 'timeout error'
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
