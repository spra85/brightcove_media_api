require File.expand_path('../spec_helper', __FILE__)

describe Brightcove::MediaAPI::Video do
  before(:all) do
    WebMock.disable_net_connect!
  end

  after(:all) do
    WebMock.allow_net_connect!
  end

  it "should create video" do
    video_path = "/ruby_application/video/uploads/test_video.mov"
    File.should_receive(:exists?).with(video_path).and_return(true)
    File.should_receive(:new).and_return(mock(File))

    Brightcove::API.stub!(:post_file).and_return({ "error" => nil, "result" => { "id" => 123456789} })

    #stub_request(:post, Brightcove::API::WRITE_API_URL).to_return(:status => 200, :body => { "error" => nil, "result" => { "id" => 123456789} })

    response = Brightcove::MediaAPI::Video.create_video(video_path)

    raise response.inspect
  end

  it "should update video"

  it "should delete video by reference id"

  it "should share video to sub-accounts"

  it "should add thumb to video"

  it "should add still to video"

  it "should find video by id"

  it "should find videos by list of ids"

  it "should find video by reference ids"

  it "should find videos by list of reference ids"

  it "should let you know if the video processing is complete"

  it "should search videos"
end
