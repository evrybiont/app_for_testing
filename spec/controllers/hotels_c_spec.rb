require 'spec_helper'

describe HotelsController do
  let(:user) { build :user }

  context '#index' do
    let(:hotel) { build_stubbed :hotel }
    before do
      Hotel.should_receive(:desc).with(:created_at).and_return([hotel])
      get :index
    end

    it { expect(assigns :hotels).to be_present }
    it { expect(response).to render_template :hotels }
  end

  context '#top' do
    let(:hotel) { build_stubbed :hotel }
    before do
      Hotel.should_receive(:top).with(described_class::COUNT).and_return([hotel])
      get :top
    end

    it { expect(assigns :hotels).to be_present }
    it { expect(response).to render_template :hotels }
  end

  context '#new' do
    context 'current_user present' do
      before do
        controller.stub(:current_user) { user }
        get :new
      end

      it { expect(assigns(:hotel).new_record?).to be_true }
      it { expect(assigns(:hotel).address).to be_present }
      it { expect(response).to render_template :form }
    end

    context 'current_user empty' do
      let(:link) { 'last_page' }
      before do
        request.env["HTTP_REFERER"] = link
        get :new
      end

      it { expect(flash[:error]).to eql I18n.t('errors.required_user') }
      it { expect(response).to redirect_to link }
    end
  end

  context '#create' do
    context 'true' do
      before do
        controller.stub(:current_user) { user }
        Hotel.any_instance.stub(:save).and_return(true)
        post :create
      end

      it { expect(assigns(:hotel).user).to be_present }
      it { expect(flash[:success]).to eql I18n.t('hotels.create') }
      it { expect(response).to redirect_to assigns :hotel }
    end

    context 'false' do
      before do
        Hotel.any_instance.stub(:save).and_return(false)
        post :create
      end

      it { expect(response).to render_template :form }
    end
  end

  context '#show' do
    let!(:hotel) { build_stubbed :hotel }
    context 'found record' do
      before do
        Hotel.stub(:where).and_return([hotel])
        get :show, id: hotel
      end

      it { expect(assigns :hotel).to be_present }
      it { expect(response).to render_template :show }
    end

    context 'not found record' do
      before do
        Hotel.stub(:where).and_return([nil])
        get :show, id: hotel
      end

      it { expect(response).to render_template(file: "#{Rails.root}/public/record_not_found.html") }
    end
  end

  context '#edit' do
    let!(:hotel) { build_stubbed :hotel }
    context 'current_user present' do
      before do
        controller.stub(:current_user) { hotel.user }
        Hotel.stub(:where).and_return([hotel])
        get :edit, id: hotel
      end

      it { expect(assigns(:hotel).user).to eql subject.current_user }
      it { expect(response).to render_template :form }
    end

    context 'current_user empty' do
      let(:link) { 'last_page' }
      before do
        request.env["HTTP_REFERER"] = link
        Hotel.stub(:where).and_return([hotel])
        get :edit, id: hotel
      end

      it { expect(flash[:error]).to eql I18n.t('errors.required_user') }
      it { expect(response).to redirect_to link }
    end

    context 'not found record' do
      before do
        Hotel.stub(:where).and_return([nil])
        get :edit, id: hotel
      end

      it { expect(response).to render_template(file: "#{Rails.root}/public/record_not_found.html") }
    end
  end

  context '#update' do
    let!(:hotel) { build_stubbed :hotel }
    context 'true' do
      before do
        controller.stub(:current_user) { hotel.user }
        Hotel.stub(:where).and_return([hotel])
        Hotel.any_instance.stub(:update_attributes).and_return(true)
        put :update, id: hotel
      end

      it { expect(assigns(:hotel).user).to eql subject.current_user }
      it { expect(flash[:success]).to eql I18n.t('hotels.update') }
      it { expect(response).to redirect_to hotel }
    end

    context 'false' do
      before do
        controller.stub(:current_user) { hotel.user }
        Hotel.stub(:where).and_return([hotel])
        Hotel.any_instance.stub(:update_attributes).and_return(false)
        put :update, id: hotel
      end

      it { expect(response).to render_template :form }
    end

    context 'not found record' do
      before do
        Hotel.stub(:where).and_return([nil])
        put :update, id: hotel
      end

      it { expect(response).to render_template(file: "#{Rails.root}/public/record_not_found.html") }
    end
  end

  context '#destroy' do
    let!(:hotel) { create :hotel }
    context 'current_user present' do
      before do
        controller.stub(:current_user) { hotel.user }
        Hotel.stub(:where).and_return([hotel])
        delete :destroy, id: hotel
      end

      it { expect(Hotel.count).to eql 0 }
      it { expect(flash[:success]).to eql I18n.t('hotels.destroy') }
      it { expect(response).to redirect_to hotels_path }
    end

    context 'current_user empty' do
      let(:link) { 'last_page' }
      before do
        request.env["HTTP_REFERER"] = link
        delete :destroy, id: hotel
      end

      it { expect(flash[:error]).to eql I18n.t('errors.required_user') }
      it { expect(response).to redirect_to link }
    end

    context 'not found record' do
      before do
        Hotel.stub(:where).and_return([nil])
        delete :destroy, id: hotel
      end

      it { expect(response).to render_template(file: "#{Rails.root}/public/record_not_found.html") }
    end
  end
end
