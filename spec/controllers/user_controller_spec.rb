require "rails_helper"
require "./app/helpers/sessions_helper"

RSpec.configure do |c|
  c.include SessionsHelper
end

RSpec.describe UsersController, type: :controller do
  let(:user) {User.new(name: Faker::Name.name,
                         email: "phanthanhdong1@gmail.com",
                         password: "123456789",
                         password_confirmation: "123456789")}
  let(:user_params) do
    {name: Faker::Name.name,
     email: "user@example.com",
     password: "123456",
     password_confirmation: "123456"}
   end

  describe "GET #new" do
    it "when yet login should render sign up page" do
      get :new
      expect(response).to have_http_status :success
      expect(subject).to render_template :new
    end

    it "when logged in should render homepage" do
      log_in user
      expect(response).to have_http_status :success
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "create new user" do
        post :create, params: {user: user_params}
        expect(flash[:notice]) == "Welcome to shopping online"
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid attributes" do
      it "when name blank don't create account" do
        user_params[:name] = " "
        post :create, params: {user: user_params}
        expect(subject).to render_template :new
        errore_msg = assigns(:user).errors.messages
        expect(errore_msg).to include(name: including(I18n.t("errors.messages.blank")))
      end

      it "when email blank don't create account" do
        user_params[:email] = " "
        post :create, params: {user: user_params}
        expect(subject).to render_template :new
        errore_msg = assigns(:user).errors.messages
        expect(errore_msg).to include(email: including(I18n.t("errors.messages.blank")))
      end

      it "when email exist don't create user" do
        user.save!
        user_params[:email] = user.email
        post :create, params: {user: user_params}
        errore_msg = assigns(:user).errors.messages
        expect(subject).to render_template :new
        errore_msg = assigns(:user).errors.messages
        expect(errore_msg).to include(email: ["has already been taken"])
      end

      it "confirmation password should be true" do
        user_params[:password] = "123456"
        user_params[:password_confirmation] = "111111"
        post :create, params: {user: user_params}
        errore_msg = assigns(:user).errors.messages
        expect(errore_msg).to include({password_confirmation: ["doesn't match Password"]})
      end
    end
  end
end
