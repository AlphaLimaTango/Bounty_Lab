require('pg')
require_relative('models/bounty')

bounty1 = Bounty.new( {
  'name' => 'Fluffy',
  'species' => 'Killer Rabbit',
  'bounty' => '2000',
  'homeworld' => 'Wonderland',
  })


bounty1.save

# bounty1.delete()
bounty1.update( {'bounty' => '7000'} )

p Bounty.find_by_name('Fluffy')
