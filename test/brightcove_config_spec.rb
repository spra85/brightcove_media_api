require File.expand_path('../spec_helper', __FILE__)

describe BrightcoveConfig do
  it "should verify read token config" do
    BrightcoveConfig.current.read_tokens.size.should == 1
    BrightcoveConfig.current.read_tokens.first.should == "read_token1"

    BrightcoveConfig.current.read_apis.first.token.should == "read_token1"
  end

  it "should verify url read token config" do
    BrightcoveConfig.current.url_read_tokens.size.should == 1
    BrightcoveConfig.current.url_read_tokens.first.should == "url_read_token1"

    BrightcoveConfig.current.url_read_apis.first.token.should == "url_read_token1"
  end

  it "should verify write token config" do
    BrightcoveConfig.current.write_tokens.size.should == 3
    BrightcoveConfig.current.write_tokens[0].should == "write_token1"
    BrightcoveConfig.current.write_tokens[1].should == "write_token2"
    BrightcoveConfig.current.write_tokens[2].should == "write_token3"

    BrightcoveConfig.current.write_apis[0].token.should == "write_token1"
    BrightcoveConfig.current.write_apis[1].token.should == "write_token2"
    BrightcoveConfig.current.write_apis[2].token.should == "write_token3"
  end
end
