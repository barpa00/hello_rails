require "rails_helper"

RSpec.describe Mission do 
  let!(:mission) { create(:mission) }

  describe "validation" do
    it "is valid with valid attributes" do
      expect(mission).to be_valid
    end
  
    it "is not valid without a title" do
      mission.title = nil
      expect(mission).to_not be_valid
    end
  end

  describe "search" do
      let!(:mission1) { create(:mission, title: 'Mission1') }
      let!(:mission2) { create(:mission, title: 'Mission2') }

    it "missions search works whith query" do
      result = Mission.ransack(title_cont_any: "Mission1").result
      expect(result.first.title).to eq "Mission1"
      expect(result.size).to eq (1)
    end
  end
end