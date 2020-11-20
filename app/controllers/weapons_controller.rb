class WeaponsController < ApplicationController
  before_action :set_weapon, only: [:destroy]
  
  def index
    @weapons = Weapon.all
  end

  def create
    @weapon = Weapon.create(params_weapon)
  end

  def destroy
    @weapon.destroy
    
    head :no_content
  end

  def show
    @weapon = Weapon.find(params[:id])
  end

  private
    def params_weapon
      params.require(:weapon).permit(:name, :power_base, :power_step, :level, :description)
    end

    def set_weapon 
      @weapon = Weapon.find(params[:id])
    end
end
