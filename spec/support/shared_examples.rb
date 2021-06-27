RSpec.shared_examples 'bad_request' do
  it do
    expect(subject).to eq 400
    expect(JSON.parse(response.body)['success']).to eq false
  end
end

RSpec.shared_examples 'not_found_request' do
  it do
    expect(subject).to eq 404
    expect(JSON.parse(response.body)['success']).to eq false
  end
end

RSpec.shared_examples 'conflict_request' do
  it do
    expect(subject).to eq 409
    expect(JSON.parse(response.body)['success']).to eq false
  end
end

RSpec.shared_examples 'created_success_request' do
  it do
    expect(subject).to eq 201
  end
end
