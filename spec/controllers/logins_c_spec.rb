require 'spec_helper'

describe LoginsController do
  context '#new' do
    before { get :new }

    it { expect(response).to render_template :new }
  end

  context '#create' do
    context 'true' do
      let(:user) { build :user }
      before do
        User.stub(:where) { [user] }
        post :create, user: { password: user.password }
      end

      it { expect(session[:user]).to be_present }
      it { expect(response).to redirect_to top_hotels_path }
    end

    context 'false' do
      before do
        User.stub(:where) { [] }
        post :create, user: {}
      end

      it { expect(flash[:error]).to eql I18n.t('logins.fail') }
      it { expect(response).to redirect_to logins_path }
    end
  end

  context '#destroy' do
    let(:user) { build :user }
    before do
      session[:user] =  user.token
      delete :destroy
    end

    it { expect(session[:user]).to be_nil }
    it { expect(response).to redirect_to top_hotels_path }
  end
end
