require 'rails_helper'

RSpec.describe MissionsController do
  describe "GET index" do
    it "assign @mission" do
      mission1 = create(:mission)
      mission2 = create(:mission)

      get :index
      
      expect(assigns[:missions]).to eq([mission2, mission1])
    end

    it "render template" do
      mission1 = create(:mission)
      mission2 = create(:mission)

      get :index

      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "assign @mission" do
      mission = build(:mission)

      get :new

      expect(assigns[:mission]).to be_a_new(Mission)
    end

    it "render template" do
      mission = build(:mission)

      get :new

      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    context "when course doesn't have a title" do
      it "doesn't create a record" do
        expect do
          post :create, params: { mission: { content: "hello" }}
        end.to change { Mission.count }.by(0)
      end
    end

    context "when course have a title" do
      it "create a new mission record" do
        mission = build(:mission)
        
        expect do 
          post :create, params: { mission: attributes_for(:mission) }     
        end.to change { Mission.count }.by(1)
      end

      it "redirects to courses_path" do
        mission = build(:mission)

        post :create, params: { mission: attributes_for(:mission) }

        expect(response).to redirect_to missions_path
      end
    end
  end

  describe "GET edit" do
    it "assign mission" do
      mission = create(:mission)
  
      get :edit , params: { id: mission.id }
  
      expect(assigns[:mission]).to eq(mission)
    end
  
    it "render template" do
      mission = create(:mission)
  
      get :edit , params: { id: mission.id }
  
      expect(response).to render_template("edit")
    end
  end

  describe "PUT update" do
    context "when course has title" do
      it "assign @mission" do
        mission = create(:mission)

        put :update, params: { id: mission.id ,mission: { title: "Mission Name", content: "Description." }}
      
        expect(assigns[:mission]).to eq(mission)
      end
    
      it "change value" do
        mission = create(:mission)
      
        put :update, params: { id: mission.id ,mission: { title: "Mission Name", content: "Description." }}
      
        expect(assigns[:mission].title).to eq("Mission Name")
        expect(assigns[:mission].content).to eq("Description.")
      end

      it "redirect to mission_path" do
        mission = create(:mission)
      
        put :update, params: { id: mission.id ,mission: { title: "Mission Name", content: "Description." }}
    
        expect(response).to redirect_to missions_path
      end
    end

    context "when course don't have title" do
      it "doesn't update a record" do
        mission = create(:mission)
      
        put :update, params: { id: mission.id, mission: { title: "", content: "hello." } }

        expect(mission.content).not_to eq("hello.")
      end

      it "redirect to mission_path" do
        mission = create(:mission)
      
        put :update, params: { id: mission.id ,mission: { title: "", content: "hello." }}
    
        expect(response).to render_template("edit")   
      end
    end
  end
  
  describe "DELETE mission" do
    it "assigns @mission" do
      mission = create(:mission)
  
      delete :destroy, params: { id: mission.id }
  
      expect(assigns[:mission]).to eq(mission)
    end

    it "deletes a mission" do
      mission = create(:mission)

      expect do 
        delete :destroy, params: { id: mission.id }     
      end.to change { Mission.count }.by(-1)
    end
  
    it "render template" do
      mission = create(:mission)

      delete :destroy, params: { id: mission.id }

      expect redirect_to missions_path
    end
  end
end