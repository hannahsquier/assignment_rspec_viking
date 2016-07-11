
require 'weapons/bow'

describe Bow do
  describe "#arrows" do 


    it "is readable" do
      expect{ subject.arrows }.not_to raise_error
    end

    it "initializes with 10 arrows" do
      expect( subject.arrows ).to eq(10)
    end

    it "creates specified number of arrows" do
      expect( Bow.new(8).arrows ).to eq(8)
    end

  end

  describe "#use" do
    it "decreases arrows by one when used" do
      subject.use
      expect(subject.arrows).to eq(9)
    end

    it "throws an arrow if there are 0 bows" do
      bow_zero = Bow.new(0)
      expect { bow_zero.use }.to raise_error
    end
  end
end