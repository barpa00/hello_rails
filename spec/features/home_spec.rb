require "rails_helper"

feature "user vist homepage" do
  let!(:missions) { create_list(:mission, 2) }

  scenario "has navbar element" do
    visit root_path
    
    expect(page).to have_text "hello"
    expect(page).to have_css "nav.navbar"
  end

  scenario "has missions list" do 
    visit root_path

    Mission.order(created_at: :DESC).each do |m|
      expect(page).to have_text(m.title)
      expect(page).to have_text(m.content)
    end
  end
end

feature "user add a new mission" do
    scenario "adding" do
      visit root_path
       
      find("a[href='#{new_mission_path}']").click
      
      expect(page).to have_content I18n.t("new_mission")

      fill_in "mission_title", with: "Mission Name"
      fill_in "mission_content", with: "Description"
      
      click_button I18n.t("button.submit")
      
      expect(page).to have_text I18n.t("mission.created")
      expect(Mission.count).to eq(1)
    end
end

feature "user edit mission" do
    scenario "editing" do
      mission = create(:mission)
      
      visit root_path
      
      find("a[href='#{edit_mission_path(mission)}']").click
      
      expect(page).to have_content I18n.t("edit_mission")
      
      expect(page).to have_field("mission_title", with: "Mission Name")
      expect(page).to have_field("mission_content", with: "Description.")
      
      fill_in "mission_content", with: "edit mission name"
      click_button I18n.t("button.submit")
      
      expect(page).to have_text I18n.t("mission.updated")
      expect(page).to have_content "edit mission name"
    end
end

feature "user delete mission", js: true do
    scenario "deleting" do 
      mission = create(:mission)
      
      visit root_path
      
      accept_alert do
        find("a[href='#{mission_path(mission)}']").click 
      end
     
      expect(page).to have_text I18n.t("mission.deleted")
    end
end
    
feature "click End Time button, missions list should sorting by end time" do
  let!(:mission1) { create(:mission, end_time: "Sun, 17 Feb 2022") }
  let!(:mission2) { create(:mission, end_time: "Sun, 28 Feb 2022") }

  scenario "click button" do
    visit root_path
    
    find("a[href='/?q%5Bs%5D=status+asc']").click
    first(".box",  text: "2022/02/17")
  end
end

feature "click Order button, missions list should sorting by status" do
  let!(:mission1) { create(:mission, status: "priority" )}
  let!(:mission2) { create(:mission, status: "norush" )}
  let!(:mission3) { create(:mission, status: "medium" )}

  scenario "click button" do
    visit root_path
    
    find("a[href='/?q%5Bs%5D=status+asc']").click
    first(".box",  text: I18n.t("norush"))
  end
end

feature "search missions works" do
  let!(:mission1) { create(:mission, title: "mission1" )}
  let!(:mission2) { create(:mission, title: "mission2" )}
  scenario "click search button" do
    visit root_path
    fill_in "q_title_cont_any", with: "mission1"
    
    click_button('搜尋')

    expect(page).to have_text("mission1")
    expect(page).to have_no_text("mission2")
  end
end