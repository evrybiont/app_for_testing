require 'spec_helper'

describe ApplicationController do
  context '#current_user' do
    let(:user) { build :user }
    before { User.stub(:where) { [user] } }

    it { expect(subject.current_user).to eql user }
  end
end
