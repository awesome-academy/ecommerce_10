require "rails_helper"

RSpec.describe "users/index.html.erb", type: :view do
  let(:user) do
    User.create(
      name: Faker::Name.name,
      email: "user@example.com",
      password: "123456",
      password_confirmation: "123456")
  end

  before do
    allow(view).to receive_messages(will_paginate: nil)
    assign :users, [user]
    render
  end

  context "should index users" do
    it {expect(rendered).to include user.name}
    it {expect(rendered).to include user.email}
    it {expect(rendered).to include user.role}
    it {expect(rendered).to include "/admin/users/#{user.id}/edit"}
    it {expect(rendered).to include "/admin/users/#{user.id}"}
  end
end
