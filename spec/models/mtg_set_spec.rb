require 'spec_helper'

describe MtgSet do

  before { @s = Factory.build(:mtg_set) }

  it { @s.should be_valid }

  describe "validations" do
    context "with no name" do
      before { @s.name = nil }

      it "is invalid" do
        @s.should have(1).error_on(:name)
        @s.errors.full_messages.should eq(["Name can't be blank"])
      end
    end

    context "when name already exists" do
      before { Factory(:mtg_set, :name => @s.name) }

      it "is invalid" do
        @s.should have(1).error_on(:name)
        @s.errors.full_messages.should eq(["Name has already been taken"])
      end
    end

    context "with no release date" do
      before { @s.released_at = nil }

      it "is invalid" do
        @s.valid?
        @s.should have(1).error#_on(:released_at)
        @s.errors.full_messages.should eq(["Must have a release date"])
      end
    end

    context "with no num cards" do
      before { @s.num_cards = nil }

      it "is invalid" do
        @s.valid?
        @s.should have(1).error
        @s.errors.full_messages.should eq(["Number of cards must be set"])
      end
    end
  end

end