require 'viking'

describe Viking do
  let(:bob) { Viking.new("Bob", 10) }
  let(:obo) {Viking.new("Obo", 15)}
  let(:jim) {Viking.new("jim", 15, 8)}
  let(:gun) { Weapon.new("Gun") }
  let(:sling) { Weapon.new("Sling") }
  let(:bow_no_arrows) { Bow.new(0) }


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
      expect{bob.pick_up_weapon("not a weapon")}.to raise_error
    end

    it "pickup up weapon will replace current weapon" do
      bob.pick_up_weapon(gun)
      expect(bob.weapon).to eq(gun)
      bob.pick_up_weapon(sling)
      expect(bob.weapon).to eq(sling)
    end
  end

  describe '#drop_weapon' do
    it 'will drop a Viking weapon leaves the Viking weaponless' do
      bob.pick_up_weapon(gun)
      expect(bob.weapon).to eq(gun)

      bob.drop_weapon
      expect(bob.weapon).to eq nil
    end
  end

  describe "#receive_attack" do
    it 'The receive_attack method calls the take_damage method' do
      expect(bob).to receive(:take_damage)

      bob.receive_attack(10)
    end

    it 'The receive_attack method calls the take_damage method' do
      bob.receive_attack(5)
      expect(bob.health).to eq 5
    end
  end

  describe '#attack' do
    it 'does something' do
      allow(bob).to receive(:damage_dealt).and_return(5)

      bob.attack(obo)
      expect(obo.health).to eq 10
    end

    it 'attacking another Viking calls that Viking take_damage method' do
      expect(bob).to receive(:take_damage)
      obo.attack(bob)
    end

    it 'attacking with no weapon runs damage_with_fists' do
      allow(bob).to receive(:damage_with_fists).and_return(1)
      expect(bob).to receive(:damage_with_fists)
      bob.attack(obo)
    end

    it "with no weapon deals Fists multiplier times strenght damage" do
      
      jim.attack(bob)
      expect(jim.send(:damage_dealt)).to eq(2)
    end

    it 'attacking with weapon runs damage_with_weapon' do
      bob.instance_variable_set(:@weapon, gun)
      allow(bob).to receive(:damage_with_weapon).and_return(1)
      expect(bob).to receive(:damage_with_weapon)
      bob.attack(obo)
    end

    it "with weapon deals weapon multiplier times strengh damage" do
      jim.instance_variable_set(:@weapon, gun)
      jim.attack(bob)
      expect(jim.send(:damage_dealt)).to eq(8)
    end

    it "with bow without enough arrows uses fists instead" do
      jim.instance_variable_set(:@weapon, bow_no_arrows)
      allow(jim).to receive(:damage_with_fists).and_return(1)
      expect(jim).to receive(:damage_with_fists)
      jim.attack(obo)
    end

    it "killing a viking raises an error" do
      expect{ jim.health = 0 }.to raise_error
    end
  end

end
