RSpec.shared_examples 'invalidation check' do |value|
  it 'checks invalidation' do
    case value
    when 'password'
      object.password = nil
    when 'content'
      object.content = nil
    else
      object[value.to_sym] = nil
    end

    expect(object).not_to be_valid
    expect(object.errors.messages[value.to_sym].to_sentence).to include("can't be blank")
    expect { object.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
