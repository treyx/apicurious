require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do

  it "responds to #index" do
    Item.create(name: "cat", description: "this is a cat.")
    get :index, format: :json
    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first
    expect(response.status).to eq(200)
    expect(item[:name]).to eq("cat")
    expect(item[:description]).to eq("this is a cat.")
  end

end
