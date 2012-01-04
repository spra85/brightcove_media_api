require File.expand_path('../spec_helper', __FILE__)

describe Brightcove::MediaAPI::Playlist do
  before(:all) do
    WebMock.disable_net_connect!
  end

  after(:all) do
    WebMock.allow_net_connect!
  end

  it "should test something"
end