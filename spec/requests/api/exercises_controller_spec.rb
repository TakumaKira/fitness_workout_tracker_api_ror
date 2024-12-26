require "rails_helper"

RSpec.describe Api::ExercisesController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:exercise) { create(:exercise, user: user) }
  let(:other_exercise) { create(:exercise, user: other_user) }

  before do
    post "/api/login", params: { email: user.email, password: user.password }
  end

  describe "access control" do
    context "when accessing other user's exercise" do
      it "cannot view other user's exercise" do
        get "/api/exercises/#{other_exercise.id}"
        expect(response).to have_http_status(:not_found)
      end

      it "cannot update other user's exercise" do
        patch "/api/exercises/#{other_exercise.id}", params: { exercise: { name: "Updated" } }
        expect(response).to have_http_status(:not_found)
      end

      it "cannot delete other user's exercise" do
        delete "/api/exercises/#{other_exercise.id}"
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
