require "rails_helper"

RSpec.describe Api::CommentsController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:workout) { create(:workout, user: user) }
  let(:other_workout) { create(:workout, user: other_user) }
  let(:comment) { create(:comment, workout: workout, user: user) }
  let(:other_comment) { create(:comment, workout: workout, user: other_user) }

  before do
    post "/api/login", params: { email: user.email, password: user.password }
  end

  describe "access control" do
    context "when accessing other user's workout" do
      it "cannot view comments on other user's workout" do
        get "/api/workouts/#{other_workout.id}/comments"
        expect(response).to have_http_status(:not_found)
      end

      it "cannot add comment to other user's workout" do
        post "/api/workouts/#{other_workout.id}/comments",
             params: { comment: { content: "Test comment" } }
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when managing comments" do
      it "cannot update other user's comment" do
        patch "/api/workouts/#{workout.id}/comments/#{other_comment.id}",
              params: { comment: { content: "Updated" } }
        expect(response).to have_http_status(:forbidden)
      end

      it "cannot delete other user's comment" do
        delete "/api/workouts/#{workout.id}/comments/#{other_comment.id}"
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
