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

  it "responds to #create" do
    expect do
      post :create, format: :json, item: { name: "Cow", description: "This is a cow."}

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)

      expect(item[:name]).to eq("Cow")
      expect(item[:description]).to eq("This is a cow.")
    end.to change{ Item.count }.from(0).to(1)
  end

  it "responds to #update" do
    old_item = Item.create(name: "cat", description: "this is a cat.")
    expect(Item.first.name).to eq(old_item.name)
    put :update, format: :json, id: old_item.id, item: { name: "Cow", description: "This is a cow."}
    expect(Item.first.name).to eq("Cow")
    expect(response.status).to eq(204)
  end


  it "responds to #destroy" do
    item = Item.create(name: "cat", description: "this is a cat.")
    delete :destroy, format: :json, id: item.id
  end
end
