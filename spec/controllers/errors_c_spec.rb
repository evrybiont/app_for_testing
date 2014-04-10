require 'spec_helper'

describe ErrorsController do
  context '#not_found' do
    before { get :not_found, a: 'not_found' }

    it { expect(response).to render_template(file: "#{Rails.root}/public/404.html") }
  end
end
