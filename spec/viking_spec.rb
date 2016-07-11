require 'viking'

describe Viking do
  let(:bob) { Viking.new("Bob", 10) }
  let(:gun) { Weapon.new("Gun") }

  describe '#initialize' do
    it "takes a name attribute" do
      expect(bob.name).to eq("Bob")
    end

    it "takes a health attribute" do
      expect(bob.health).to eq(10)
    end

    it "does not allow you to override health" do
      expect{ bob.health = 100 }.to raise_error
    end

    it "sets viking weapon to nil initially" do
      expect(bob.weapon).to eq(nil)
    end
  end

  describe '#pick_up_weapon' do
    it "sets weapon to picked up weapon" do
      bob.pick_up_weapon(gun)
      expect(bob.weapon).to eq(gun)
    end

    it "raises an error if you pickup a non weapon" do
    end
  end

end
