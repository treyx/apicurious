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

  it "responds to #show" do
    item = Item.create(name: "cat", description: "this is a cat.")
    get :show, format: :json, id: item.id

    first_item = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)

    expect(first_item[:name]).to eq("cat")
    expect(first_item[:description]).to eq("this is a cat.")
  end

end
