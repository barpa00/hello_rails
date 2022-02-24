require "rails_helper"

RSpec.describe 'Home', type: :feature do

  let!(:origin_password) { Faker::Number.number(digits: 10) }
  let!(:user) { create(:user, password: origin_password) }

  before do
    visit log_in_users_path 
    fill_in "user_email", with: user.email
    fill_in "user_password", with: origin_password
    click_on I18n.t("button.submit")
  end

  describe "user vist homepage" do
    context "has navbar element" do
      it do 
        expect(page).to have_text "hello"
        expect(page).to have_css "nav.navbar"
      end
    end
    
    context "has missions list" do 
      let!(:test_mission) { create(:mission, user: user) }
      before { visit root_path }

      it "page have missions list" do
        expect(page).to have_text(test_mission.title)
        expect(page).to have_text(test_mission.content)
      end
    end
  end

  describe "user add a new mission" do
    let(:contents) { [I18n.t("new_mission"), I18n.t("mission.title"), I18n.t("mission.content")] }

    before do
      find("a[href='#{new_mission_path}']").click
    end

    it "go mission page" do
      contents.each do |content|
        expect(page).to have_content content
      end     
    end

    context "add a new mission" do
      before do
        fill_in "mission_title", with: "New Mission"
        fill_in "mission_content", with: "New Description"
        click_button I18n.t("button.submit")
      end

      it "page have a new mission" do 
        expect(page).to have_text I18n.t("mission.created")  
        expect(Mission.where(user_id: user.id).count).to eq(1)
      end
    end
  end

  describe "user edit mission" do
    let!(:mission) { create(:mission, user: user) }

    before do
      visit root_path
      find("a[href='#{edit_mission_path(mission)}']").click
      # execute_script("document.querySelector('.spec_edit_button a').click()")
    end
    
    it "go edit page" do
      expect(page).to have_content I18n.t("edit_mission")
      expect(page).to have_field("mission_title", with: "Mission Name")
      expect(page).to have_field("mission_content", with: "Description.")
    end
    
    context "edit a mission" do
      before do 
        fill_in "mission_content", with: "edit mission name"
        click_button I18n.t("button.submit")
      end

      it "page have edited mission name" do
        expect(page).to have_text("edit mission name")
        expect(page).to have_text I18n.t("mission.updated")
      end
    end
  end

  describe "user delete mission", js: true do
    let!(:mission) { create(:mission, user: user) }
    before do
      accept_alert do
        find("a[href='#{mission_path(mission)}']").click 
      end
    end
    context "page deleted" do 
      it "page have delete message"do
        expect(page).to have_text I18n.t("mission.deleted")
      end 
    end 
  end
    
  describe "click End Time button, missions list should sorting by end time" do
    let!(:mission1) { create(:mission, end_time: "Sun, 17 Feb 2022", user: user) }
    let!(:mission2) { create(:mission, end_time: "Sun, 28 Feb 2022", user: user) }
    before do
      visit root_path 
      # byebug
      find("a[href='/?q%5Bs%5D=status+asc']").click
      # execute_script("document.querySelector('.spec_endTime_button a').click()")
    end
    context "click button" do
      it "sorting by end time" do
        expect(page).to have_text("2022/02/17")
        expect(page).to have_text("2022/02/28")
      end
    end
  end

  describe "click Order button, missions list should sorting by status" do
    let!(:mission1) { create(:mission, status: "priority", user: user )}
    let!(:mission2) { create(:mission, title: "noRushMission", status: "norush", user: user)}
    let!(:mission3) { create(:mission, status: "medium", user: user )}
    before do
      visit root_path
      find("a[href='/?q%5Bs%5D=status+asc']").click
    end
    context "click button" do
      it "sorting by status" do
        within find(".box", text: I18n.t("norush")) do
          expect(page).to have_text("noRushMission")
        end
      end
    end
  end

  describe "search missions works" do
    let!(:mission1) { create(:mission, title: "mission1", user: user )}
    let!(:mission2) { create(:mission, title: "mission2", user: user )}
    before do
      visit root_path
    end
    context "click search button" do
      before do
        fill_in "q_title_cont_any", with: "mission1"
        click_button('搜尋')
      end
      it "find something" do
        expect(page).to have_text("mission1")
        expect(page).to have_no_text("mission2")
      end
    end
  end
end