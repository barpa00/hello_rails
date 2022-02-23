class MissionsController < ApplicationController
    before_action :find_mission, only: [:update, :destroy, :edit]

    def index
      @q = Mission.where(user_id: session[:hellorails]).ransack(params[:q])
      @missions = @q.result(distinct: true).page(params[:page]).per(10)      
      if params[:id]
        change_state
      end
    end

    def new
      @mission = Mission.new
    end

    def create
      @mission = current_user.missions.create(mission_params)
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
      if params[:event] == 'todo' && @mission.doing?
        @mission.todo! 
      elsif params[:event] == 'done' && @mission.processing?
        @mission.done!
      elsif params[:event] == 'undo' && @mission.finishing?
        @mission.undo!
      else
        redirect_to missions_path
      end
    end
end
