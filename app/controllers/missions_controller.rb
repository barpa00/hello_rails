class MissionsController < ApplicationController
    before_action :find_mission, only: [:update, :destroy]

    def index
      @missions = Mission.all
    end

    def new
      @mission = Mission.new
    end

    def create
      @mission = Mission.new(mission_params)
      if @mission.save
        redirect_to missions_path, notice: "新增成功 :)" 
      else
        render :new
      end
    end

    def edit
      find_mission    
    end

    def update
      if @mission.update(mission_params)
        redirect_to missions_path, notice: "修改成功 ::)"
      else
        render :edit
      end
    end

    def destroy
      @mission.destroy if @mission
      redirect_to missions_path, notice: "已刪除", status: :see_other
    end
    
    private 
    def mission_params
      params.require(:mission).permit(:title, :content)
    end

    def find_mission
      @mission = Mission.find_by(id: params[:id])
    end
end
