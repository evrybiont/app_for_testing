require 'spec_helper'

describe ApplicationHelper do
  context 'active' do
    context 'true' do
      before { params[:action] = 'top' }

      it { expect(active('top')).to eql 'active' }
    end

    context 'false' do
      before { params[:action] = 'index' }

      it { expect(active('top')).to eql '' }
    end
  end

  context 'signin_out' do
    context 'current_user present' do
      let(:user) { build :user }
      before { helper.stub(:current_user) { user } }

      it { expect(helper.signin_out).to have_link I18n.t('navbar.log_out') }
    end

    context 'current_user present' do
      before { helper.stub(:current_user) { nil } }

      it { expect(helper.signin_out).to have_link I18n.t('navbar.login') }
    end
  end

  context 'user_name' do
    context 'current_user present' do
      let(:profile) { build_stubbed :profile }
      before { helper.stub(:current_user) { profile.user } }

      it { expect(helper.user_name).to eql profile.full_name }
    end

    context 'current_user empty' do
      before { helper.stub(:current_user) { nil } }

      it { expect(helper.user_name).to eql '' }
    end
  end

  context 'flash_class' do
    context 'flash error' do
      before { flash[:error] = true }

      it { expect(flash_class).to eql 'alert-danger' }
    end

    context 'flash success' do
      before { flash[:error] = false }

      it { expect(flash_class).to eql 'alert-success' }
    end
  end
end
