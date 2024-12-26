require "rails_helper"

RSpec.describe Api::WorkoutsController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:workout) { create(:workout, user: user) }
  let(:other_workout) { create(:workout, user: other_user) }

  before do
    post "/api/login", params: { email: user.email, password: user.password }
  end

  describe "access control" do
    context "when accessing other user's workout" do
      it "cannot view other user's workout" do
        get "/api/workouts/#{other_workout.id}"
        expect(response).to have_http_status(:not_found)
      end

      it "cannot update other user's workout" do
        patch "/api/workouts/#{other_workout.id}", params: { workout: { name: "Updated" } }
        expect(response).to have_http_status(:not_found)
      end

      it "cannot delete other user's workout" do
        delete "/api/workouts/#{other_workout.id}"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
