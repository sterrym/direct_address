require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DirectAddress" do
	before(:all) do
		@country = Country.create(:abbrev => 'US', :name => 'United States')
		@region = Region.create(:name => 'Kansas', :country => @country)
		@user = User.create(:name => 'Mike')
		@address = Address.create(:addressable => @user, :country => @country, :region => @region, :street1 => '54 Parkins Way', :city => 'Whitmore', :postal => '04330')
	end
	
  it "should validate countries properly" do
    c = Country.new
		c.valid?.should be_false
		c.abbreviation = @country.abbrev
		c.valid?.should be_false
		c.name = @country.name
		c.valid?.should be_true
  end

	it "should validate regions properly" do
		r = Region.new
		r.valid?.should be_false
		r.name = @region.name
		r.valid?.should be_false
		r.country = @country
		r.valid?.should be_true
	end
	
	it "should output addresses properly" do 
		@address.multiline.should eql([@address.street1, "#{@address.city} #{@address.region_name} #{@address.postal}", @address.country_abbrev])
		@address.single_line.should eql([@address.street1, "#{@address.city} #{@address.region_name} #{@address.postal}", @address.country_abbrev].join(', '))
	end
	
	it "should validate length of abbreviation" do 
		c = Country.new(:abbrev => 'a', :name => 'america')
		c.valid?.should be_false
	end
	
	it "should format the abbreviation" do 
		c = Country.create(:abbrev => 'aa', :name => 'All Americas')
		c.abbrev.should eql('AA')
	end
end
