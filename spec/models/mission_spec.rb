require "rails_helper"

RSpec.describe Mission do 
  let!(:user) { create(:user)}
  
  describe "validation" do
    let!(:mission) { create(:mission, user: user) }
    it "is valid with valid attributes" do
      expect(mission).to be_valid
    end
  
    it "is not valid without a title" do
      mission.title = nil
      expect(mission).to_not be_valid
    end
  end

  describe "search" do
      let!(:mission1) { create(:mission, title: 'Mission4', user: user) }
      let!(:mission2) { create(:mission, title: 'Mission5', user: user) }

    it "missions search works whith query" do
      result = Mission.ransack(title_cont_any: "Mission4").result
      expect(result.first.title).to eq "Mission4"
      expect(result.size).to eq (1)
    end
  end
end