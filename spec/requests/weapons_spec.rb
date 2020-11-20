require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /weapons" do

    it "All weapons are viewed in index" do 
      weapons = create_list(:weapon, 10)
      get weapons_path
      expect(response).to have_http_status(200)
      weapons.each do |weapon|
        expect(response.body).to include(weapon.name, weapon.current_power, weapon.title, weapon_path(weapon))
      end
    end

    it "All details about one weapon" do 
      weapon = create(:weapon)
      get weapon_path(weapon)
      expect(response.body).to include(weapon.name, weapon.description, weapon.power_base.to_s, weapon.power_step.to_s, weapon.level.to_s, weapon.current_power, weapon.title)
    end
  end

  describe "POST /weapons" do
    it "Has created a new weapon" do
      weapon_attr = FactoryBot.attributes_for(:weapon)
      post weapons_path, params: {weapon: weapon_attr}
      expect(Weapon.last).to have_attributes(weapon_attr) 
    end

    it "Don't create" do 
      expect{
        post weapons_path, params: {weapon: {name:'', description:'', power_base:'', powe_step:'', level:'' }}
    }.to_not change(Weapon, :count)
    end
  end

  describe "DELETE /weapons" do 
    it "Success delete" do 
      weapon = create(:weapon)
      delete "/weapons/#{weapon.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end