class EducationLevel
  LEVELS = {
    0 => { description: 'No Aplica' },
    1 => { description: 'Primaria' },
    2 => { description: 'Secundaria' },
    3 => { description: 'Preparatoria' },
    4 => { description: 'Licenciatura' },
    5 => { description: 'Especialidad' },
    6 => { description: 'Maestría' },
    7 => { description: 'Doctorado' }
  }.freeze

  def self.all
    LEVELS
  end
end
