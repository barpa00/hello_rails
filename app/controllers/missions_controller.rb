class MissionsController < ApplicationController
    before_action :find_mission , only: [:update, :destroy, :edit]
    before_action :current_user_not_found

    def index
      @q = current_user.missions.ransack(params[:q])
      @missions = @q.result(distinct: true).page(params[:page]).per(10)      
      if params[:id]
        change_state
      end
    end

    def new
      @mission = Mission.new
    end

    def create
      if @mission = current_user.missions.create(mission_params)
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
      params.require(:mission).permit(:title, :content, :status, :end_time, :aasm_state, :user_id, :all_tags)
    end

    def find_mission
      begin
        @mission = Mission.find_by!(id: params[:id], user: current_user) 
      rescue
        raise ActiveRecord::RecordNotFound
      end
    end

    def current_user_not_found
      if current_user.nil?
        redirect_to log_in_path, notice: "請先登入"
      end
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
