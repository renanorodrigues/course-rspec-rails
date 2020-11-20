require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "GET /enemies" do 
    context "When has all enemies created" do 
      let!(:enemies) {create_list(:enemy, 20)}
      let(:enemy_attr) {attributes_for(:enemy)}

      before(:each) {get enemies_path}

      it "returns status code 200" do 
        expect(response).to have_http_status(200)
      end

      it "return total enemies JSON" do 
        expect(json['tot']).to eq(enemies.count)
      end

      xit "return all enemies JSON" do 
          # expect(json['enemies'][index]).to match(enemy.to_json)
          enemies.each_with_index do |enemy, index| 
            expect(json['enemies'][index]).to match(enemy.to_json)
          end  
      end
      
    end

    context 'When especify one enemy' do 
      let(:enemy) {create(:enemy)}
      let(:enemy_attr) {attributes_for(:enemy)}

      before(:each) {get "/enemies/#{enemy.id}", params: {enemy: enemy_attr}}

      it "returns an enemy by id" do
        expect(enemy).to have_attributes(json.except('created_at', 'updated_at'))   
      end
    end 
  end 

  describe "POST /enemies" do 
    context 'When create an enemy' do 
      let(:enemy) {create(:enemy)}
      let(:enemy_attr) {attributes_for(:enemy)}

      it "responds with success" do
        headers = { "ACCEPT" => "application/json" }
        # post "/widgets", :params => { :widget => {:name => "My Widget"} }, :headers => headers
        post enemies_path, :params => { :enemy => enemy_attr}, :headers => headers
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:created)
      end
      
      xit "returns messages ok" do
        expect(response.body).to eq 'ok'  
      end
      
    end
  end

  describe "PUT /enemies" do 
    context "when the enemy exists" do
      let(:enemy) {create(:enemy)} 
      let(:enemy_attr) {attributes_for(:enemy)}

      before(:each) {put "/enemies/#{enemy.id}", params: enemy_attr}

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "updates the record" do
        expect(enemy.reload).to have_attributes(enemy_attr)  
      end

      it "returns the enemy updated" do
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))  
      end
    end

    context "when the enemy does not exist" do
      before(:each) {put '/enemies/0', params: attributes_for(:enemy)}

      it "returns status code 404" do
        expect(response).to have_http_status(404)  
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)  
      end
    end
  end
  
  describe "DELETE /enemies" do 
    context "when the enemy exists" do
      let(:enemy) {create(:enemy)}
      before(:each) {delete "/enemies/#{enemy.id}"}

      it "returns status code 204" do
        expect(response).to have_http_status(204)  
      end

      it "destroy the record" do
        expect{enemy.reload}.to raise_error ActiveRecord::RecordNotFound  
      end
  
    end

    context "when the enemy does not exist" do
      before(:each) {delete '/enemies/0'}

      it "returns status code 404" do
        expect(response).to have_http_status(404)  
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy/)  
      end
      
    end
  end
end
