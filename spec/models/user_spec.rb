require 'spec_helper'

describe User do
  context 'attr' do
    it { should have_fields(:token, :email, :encrypted_password) }
    it { should be_timestamped_document }
  end

  context 'association' do
    it { should embed_one :profile }
    it { should have_many :hotels }
  end

  context 'nested attributes' do
    it { should accept_nested_attributes_for :profile }
  end

  context 'validates' do
    it { should validate_presence_of :token }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
    it { should validate_length_of(:password).within(6..30) }
    it { should validate_format_of :password }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_format_of :email }
  end

  context 'delegate' do
    let(:profile) { build_stubbed :profile }
    let(:user)    { profile.user }

    it { expect(user.full_name).to eql profile.full_name }
  end
end
