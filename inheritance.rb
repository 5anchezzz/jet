module AnimalModule
  def speak
    puts "#{self.class.name} can't talk really..."
    super
  end
end

class Animal
  prepend AnimalModule

  def speak
    puts "... said Animal"
  end
end

class Cat < Animal
  def speak
    puts "Meow!"
    super
  end
end

cat = Cat.new
cat.speak

puts "ANCESTORS FOR CAT:"
puts Cat.ancestors

def test(arr)
  arr.each do |number|
    case number
    when 0
      pp 'zer'
      # zer += 1
    when ->(x) { x > 0}
      pp 'pos'
      # pos += 1
    when ->(x) { x < 0}
      pp 'neg'
      # neg += 1
    end
  end
end

let!(:interface_item_second) { create(:interface_item, :lead_client_crm_id, interface: interface) }
let!(:participation_no_lead) { build(:interface_participation, interface: interface) }
let!(:lead_with_client_crm_id) { create(:lead, client: participation_no_lead.client, client_crm_id: '99999') }


context 'when there is mapping by client_crm_id and lead present' do
  before do
    interface_item_second.set(participation_no_lead, '99999')
  end

  it 'lead was found' do
    expected = described_class.new(participation_no_lead).invoke!(data: participation_no_lead.parsed_data)

    expect(expected).to match(instance_of(Lead))
  end
end