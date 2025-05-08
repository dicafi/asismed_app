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

# Diagnostics
if Diagnostic.count.zero?
  puts 'Creating Diagnostics...'
  Diagnostic.create([
    { key: 'A00', description: 'Cólera' },
    { key: 'A01', description: 'Fiebre tifoidea y paratifoidea' },
    { key: 'A02', description: 'Otras infecciones intestinales debidas a microorganismos' },
    { key: 'A03', description: 'Shigelosis' },
    { key: 'A04', description: 'Otras infecciones intestinales bacterianas' }
  ])
else
  puts 'Diagnostics already exist, skipping creation.'
end
