class MaritalStatus
  STATUSES = {
    0 => { description: 'Soltero(a)' },
    1 => { description: 'Casado(a)' },
    2 => { description: 'Divorciado(a)' },
    3 => { description: 'Union Libre' },
    4 => { description: 'Concubinato' },
    5 => { description: 'Viudo(a)' }
  }.freeze

  def self.all
    STATUSES
  end
end
