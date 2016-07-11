require 'warmup'

describe Warmup do

  describe "#gets_shout" do
    
    
    it "will return the input with upcase letters" do
      allow(subject).to receive(:gets).and_return("hello")
      expect(subject.gets_shout).to eq("HELLO")
    end

  end

  describe "#triple_size" do 
    it "will return three times the size of the array" do
      array_double = double('Array', size: 5)
      expect(subject.triple_size(array_double)).to eq(15)
    end

  end

  describe "#calls_some_methods" do
    context "string is empty" do
      
      it "calls empty? when string is empty" do
        empty_string_double = double("String", empty?: true)
        expect{ subject.calls_some_methods(empty_string_double)}.to raise_error
      end

    end

    context "string is not empty" do
      it "calls empty?, upcase! when string is not empty" do
        non_empty_string_double = double("String", empty?: false, upcase!: "HELLO" )
        expect(subject.calls_some_methods(non_empty_string_double)).to receive(:upcase!)
      end
    end
  end
end
