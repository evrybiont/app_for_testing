require 'spec_helper'

describe CommentsController do
  let(:user) { build :user }
  context 'current_user present' do
    let!(:hotel) { build_stubbed :hotel }
    before do
      controller.stub(:current_user) { user }
      Hotel.stub(:where).and_return([hotel])
      post :create, comment: {}
    end

    it { expect(assigns(:hotel).comments).to be_present }
    it { expect(assigns(:hotel).comments.first.user_id.present?).to be_true }
  end

  context 'current_user empty' do
    let(:link) { 'last_page' }
    before do
      request.env["HTTP_REFERER"] = link
      post :create
    end

    it { expect(flash[:error]).to eql I18n.t('errors.required_user') }
    it { expect(response).to redirect_to link }
  end
end
