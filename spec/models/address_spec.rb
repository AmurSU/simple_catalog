require "spec_helper"

describe Address do

  it "is invalid without url" do
    address = build(:address, url: nil)
    address.should_not be_valid
  end

  it "is invalid without description" do
    address = build(:address, description: nil)
    address.should_not be_valid
  end

  it "stores unique url for each discipline" do
    url = "http://example.com/"
    discipline = create(:discipline)
    address_1 = create(:address, url: url, discipline: discipline)
    address_2 = build(:address, url: url, discipline: discipline)
    address_2.should_not be_valid
    address_3 = build(:address, url: url)
    address_3.should be_valid
  end

  it "respects domain zones and generate domain correctly" do
    zone = create(:zone)
    address = create(:address, url: "http://site#{zone.suffix}")
    address.domain.should == "site#{zone.suffix}"
  end

  it "stores domain and normalized parts in database" do
    address = create(:address)
    address[:domain].should_not be_blank
    address[:normalized_url].should_not be_blank
    address[:normalized_domain].should_not be_blank
  end

  it "appropriately stores IDN hostnames" do
    address = create(:address_idn)
    address[:normalized_domain].should == IDN::Idna.toASCII(address[:domain])
  end

  it "appropriately stores normalized links" do
    address = create(:address_idn_with_path)
    address[:normalized_url].should == Addressable::URI.parse(address[:url]).normalize.to_s
  end

  it "assumes http protocol if unspecified" do
    address = build(:address, url: "example.org")
    address.should be_valid
    address.url.should == "http://example.org"
  end

end
