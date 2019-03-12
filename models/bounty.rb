class Bounty
  attr_accessor :name, :species, :bounty, :homeworld
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @species = options['species']
    @bounty = options['bounty']
    @homeworld = options['homeworld']
  end

  def save()
     db = PG.connect(dbname: 'bounty')

     sql = 'INSERT INTO bounties (name, species, bounty, homeworld) VALUES ($1, $2, $3, $4) RETURNING *;'

     values = [@name, @species, @bounty, @homeworld]

     db.prepare('insert', sql)
     result = db.exec_prepared('insert', values)
     @id = result[0]['id']
     db.close()
  end

  def delete()
    db = PG.connect(dbname: 'bounty')

    sql = 'DELETE FROM bounties WHERE id = $1;'

    db.prepare('delete', sql)
    db.exec_prepared('delete', [@id])
    db.close()
  end

  def Bounty.delete_all()
    db = PG.connect(dbname: 'bounty')

    sql = 'DELETE FROM bounties;'
    db.prepare('delete_all', sql)
    db.exec_prepared('delete_all', [])
    db.close()
  end

  def update(options)
    @name = options['name'] if options['name']
    @species = options['species'] if options['species']
    @bounty = options['bounty'] if options['bounty']
    @homeworld = options['homeworld'] if options['homeworld']

    db = PG.connect(dbname: 'bounty')

    sql = 'UPDATE bounties SET (name, species, bounty, homeworld) = ($1, $2, $3, $4) WHERE id = $5;'

    values = [@name, @species, @bounty, @homeworld, @id]

    db.prepare('update', sql)
    db.exec_prepared('update', values)

    db.close()
  end

  def Bounty.find_by_name(name)
    db = PG.connect(dbname: 'bounty')

    sql = 'SELECT * FROM bounties WHERE name = $1;'

    values = [name]

    db.prepare('find_by_name', sql)
    result = db.exec_prepared('find_by_name', values)
    puts result[0]
    objects = result.map { |hash| Bounty.new(hash) }
    db.close()
    return objects
  end

end
