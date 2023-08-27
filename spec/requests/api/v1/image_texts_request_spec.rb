require 'rails_helper'

RSpec.describe "Api::V1::ImageTexts", type: :request do
  describe "GET /wakeup" do
    it "returns server is awake message" do
      get api_v1_wakeup_path

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq("message" => "Server is awake")
    end
  end

  describe "POST /preview" do
    let(:valid_params) do
      {
        image_text: {
          nickname: "John",
          hobby: "Reading",
          message: "Hello World"
        }
      }
    end

    it "returns encoded image" do
      post api_v1_image_texts_preview_path, params: valid_params

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["url"]).to start_with("data:image/jpg;base64,")
    end
  end

  describe "POST /create" do
    # Mock the S3 upload to prevent actual uploads in tests
    before do
      allow_any_instance_of(ImageUploader).to receive(:upload).and_return("https://mocked-s3-url.com/image.jpg")
    end

    let(:valid_params) do
      {
        image_text: {
          nickname: "John",
          hobby: "Reading",
          message: "Hello World"
        }
      }
    end

    it "creates a new image text and returns its URL" do
      expect {
        post api_v1_image_texts_path, params: valid_params
      }.to change(ImageText, :count).by(1)

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["url"]).to eq("https://mocked-s3-url.com/image.jpg")
    end
  end

  describe "GET /show" do
    let!(:image_text) { ImageText.create!(nickname: "John", hobby: "Reading", message: "Hello", image_url: "https://sample.com/image.jpg") }

    it "returns the image text details for valid id" do
      get api_v1_image_text_path(image_text)

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["image_url"]).to eq(image_text.image_url)
    end

    it "returns error for invalid id" do
      get api_v1_image_text_path(id: 9999)

      expect(response).to have_http_status(404)
      expect(JSON.parse(response.body)).to eq("error" => "Image not found")
    end
  end
end
