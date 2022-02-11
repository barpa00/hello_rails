require "rails_helper"

feature "user vist homepage" do
  scenario "has navbar element" do
    visit root_path
    
    expect(page).to have_text "hello"
    expect(page).to have_css "nav.navbar"
  end

  scenario "has missions list" do
    mission1 = create(:mission)
    mission2 = create(:mission)  

    visit root_path
    
    expect(page).to have_text "Mission Name"
    expect(page).to have_text "Description"
    expect(page).to have_text "Mission Name"
    expect(page).to have_text "Description"
  end

  feature "user add a new mission" do
    scenario "adding" do
      visit root_path
       
      find("a[href='#{new_mission_path}']").click
      
      expect(page).to have_content "新增任務"

      fill_in "任務名稱", with: "Mission Name"
      fill_in "任務內容", with: "Description."

      click_button "Create Mission"

      expect(page).to have_text "新增成功 :)"
      expect(page).to have_content "Mission Name"
    end
  end

  feature "user edit mission" do
    scenario "editing" do
      mission = create(:mission)

      visit root_path

      find("a[href='#{edit_mission_path(mission)}']").click

      expect(page).to have_content "編輯任務"

      expect(page).to have_field("任務名稱", with: "Mission Name")
      expect(page).to have_field("任務內容", with: "Description.")

      fill_in "任務名稱", with: "edit mission name"

      click_button "Update Mission"

      expect(page).to have_text "修改成功 ::)"
      expect(page).to have_content "edit mission name"
    end
  end

  feature "user delete mission", js: true do
    scenario "deleting" do 
      mission = create(:mission)

      visit root_path
      find("a[href='#{mission_path(mission)}']").click 

      # expect(page).to have_text "已刪除"
    end
  end
    
end
