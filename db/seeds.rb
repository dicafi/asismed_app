# Aseguradoras
if Insurer.count.zero?
  puts 'Creating Insurers...'
  Insurer.create([
    { description: 'IMSS' },
    { description: 'ISSSTE' },
    { description: 'SEGURO POPULAR' },
    { description: 'GASTOS MEDICOS MAYORES' },
    { description: 'OTROS' }
  ])
else
  puts 'Insurers already exist, skipping creation.'
end

# Marital Status
if MaritalStatus.count.zero?
  puts 'Creating Marital Statuses...'
  MaritalStatus.create([
    { description: 'Soltero(a)' },
    { description: 'Casado(a)' },
    { description: 'Divorciado(a)' },
    { description: 'Union Libre' },
    { description: 'Concubinato' },
    { description: 'Viudo(a)' }
  ])
else
  puts 'MaritalStatuses already exist, skipping creation.'
end

# Education Levels
if EducationLevel.count.zero?
  puts 'Creating Education Levels...'
  EducationLevel.create([
    { description: 'No Aplica' },
    { description: 'Primaria' },
    { description: 'Secundaria' },
    { description: 'Preparatoria' },
    { description: 'Licenciatura' },
    { description: 'Especialidad' },
    { description: 'Maestría' },
    { description: 'Doctorado' }
  ])
else
  puts 'EducationLevels already exist, skipping creation.'
end
