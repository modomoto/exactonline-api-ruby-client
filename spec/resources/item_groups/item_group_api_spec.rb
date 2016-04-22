require 'spec_helper'

describe Elmas::ItemGroup do
  before do
    stub_request(:get, "https://start.exactonline.nl/api/v1//Current/Me").
       with(:headers => {'Accept'=>'application/response_format', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Bearer access_token', 'Content-Type'=>'application/response_format', 'User-Agent'=>'Ruby'}).
       to_return(:status => 200, :body => "", :headers => {})
  end

  it "can initialize" do
    item_group = Elmas::ItemGroup.new
    expect(item_group).to be_a(Elmas::ItemGroup)
  end

  it "accepts attribute setter" do
    item_group = Elmas::ItemGroup.new
    item_group.code = "78238"
    expect(item_group.code).to eq "78238"
  end

  it "returns value for getters" do
    item_group = Elmas::ItemGroup.new({ "Code" => "345" })
    expect(item_group.code).to eq "345"
  end

  it "crashes and burns when getting an unset attribute" do
    item_group = Elmas::ItemGroup.new({ name: "Piet" })
    expect(item_group.try(:code)).to eq nil
  end

  let(:resource) { resource = Elmas::ItemGroup.new(id: "12abcdef-1234-1234-1234-123456abcdef", code: "1223") }

  context "Applying filters" do
    it "should apply ID filter for find" do
      expect(Elmas).to receive(:get).with("logistics/ItemGroups(guid'12abcdef-1234-1234-1234-123456abcdef')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      expect(Elmas).to receive(:get).with("logistics/ItemGroups?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      expect(Elmas).to receive(:get).with("logistics/ItemGroups?$filter=Code+eq+'1223'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:code, :id])
    end
  end

  context "Applying order" do
    it "should apply the order_by and filters" do
      expect(Elmas).to receive(:get).with("logistics/ItemGroups?$order_by=Code&$filter=Code+eq+'1223'&$filter=ID+eq+guid'12abcdef-1234-1234-1234-123456abcdef'")
      resource.find_by(filters: [:code, :id], order_by: :code)
    end

    it "should only apply the order_by" do
      expect(Elmas).to receive(:get).with("logistics/ItemGroups?$order_by=Code")
      resource.find_all(order_by: :code)
    end
  end

  context "Applying select" do
    it "should apply one select" do
      expect(Elmas).to receive(:get).with("logistics/ItemGroups?$select=Code")
      resource.find_all(select: [:code])
    end

    it "should apply one select with find_by" do
      expect(Elmas).to receive(:get).with("logistics/ItemGroups?$select=Code")
      resource.find_by(select: [:code])
    end

    it "should apply one select" do
      expect(Elmas).to receive(:get).with("logistics/ItemGroups?$select=Code,Id")
      resource.find_all(select: [:code, :id])
    end
  end
end
