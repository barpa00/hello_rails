require "rails_helper"

RSpec.describe Mission do
  before(:all) do
    @mission = build(:mission)
  end

  it "is valid with valid attributes" do
    expect(@mission).to be_valid
  end

  it "is not valid without a title" do
    @mission.title = nil
    expect(@mission).to_not be_valid
  end
end