require 'spec_helper'

describe SignupsController do
  context '#new' do
    context 'current user empty' do
      before { get :new }

      it { expect(assigns(:user).new_record?).to be_true }
      it { expect(assigns(:user).profile).to be_present }
      it { expect(response).to render_template :new }
    end

    context 'current user present' do
      let(:user) { build :user }
      before do
        controller.stub(:current_user) { user }
        get :new
      end

      it { expect(flash[:error]).to eql I18n.t('signups.already_signup') }
      it { expect(response).to redirect_to top_hotels_path }
    end
  end

  context '#create' do
    context 'true' do
      let!(:user) { build :user }
      before do
        User.stub(:new).and_return(user)
        User.any_instance.stub(:save).and_return(true)
        post :create, user: {}
      end

      it { expect(session[:user]).to be_present }
      it { expect(flash[:success]).to eql I18n.t('signups.create') }
      it { expect(response).to redirect_to top_hotels_path }
    end

    context 'false' do
      before do
        User.any_instance.stub(:save).and_return(false)
        post :create, user: {}
      end

      it { expect(response).to render_template :new }
    end
  end
end
