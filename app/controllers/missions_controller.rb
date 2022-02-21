class MissionsController < ApplicationController
    before_action :find_mission, only: [:update, :destroy, :edit]

    def index
      @q = Mission.ransack(params[:q])
      @missions = @q.result(distinct: true)

      if params[:id]
        change_state
      end
    end

    def new
      @mission = Mission.new
    end

    def create
      @mission = Mission.new(mission_params)
      if @mission.save
        redirect_to missions_path, notice: I18n.t("mission.created")
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @mission.update(mission_params)
        redirect_to missions_path, notice: I18n.t("mission.updated")
      else
        render :edit
      end
    end

    def destroy
      @mission.destroy if @mission
      redirect_to missions_path, notice: I18n.t("mission.deleted"), status: :see_other
    end
    
    private 
    def mission_params
      params.require(:mission).permit(:title, :content, :status, :end_time, :aasm_state)
    end

    def find_mission
      @mission = Mission.find_by(id: params[:id])
    end

    def change_state
      find_mission
      if params[:event] == 'todo'
        @mission.todo! 
      elsif params[:event] == 'done'
        @mission.done!
      else
        @mission.undo!
      end
      redirect_to missions_path
    end
end
