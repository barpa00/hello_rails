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
    




