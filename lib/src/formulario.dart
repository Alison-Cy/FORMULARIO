import 'package:flutter/material.dart';

class Fomrulario extends StatefulWidget {
  const Fomrulario({super.key});

  @override
  State<Fomrulario> createState() => _FomrularioState();
}

class _FomrularioState extends State<Fomrulario> {
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController ciController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController nombresController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController edadController = TextEditingController();

  String selectedSexo = 'Masculino';
  String? selectedEstadoCivil;
  DateTime? fechaNacimiento;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Clientes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('C.I.'),
                TextFormField(
                  controller: ciController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El C.I. es obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Nombres Completos'),
                TextFormField(
                  controller: nombresController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Los nombres son obligatorios';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Apellidos Completos'),
                TextFormField(
                  controller: apellidosController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Los apellidos son obligatorios';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Teléfono'),
                TextFormField(
                  controller: telefonoController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El teléfono es obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Dirección'),
                TextFormField(
                  controller: direccionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La dirección es obligatoria';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Correo Electrónico'),
                TextFormField(
                  controller: correoController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El correo electrónico es obligatorio';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}").hasMatch(value)) {
                      return 'Ingresa un correo válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Sexo'),
                Row(
                  children: [
                    Radio(
                      value: 'Masculino',
                      groupValue: selectedSexo,
                      onChanged: (value) {
                        setState(() {
                          selectedSexo = value.toString();
                        });
                      },
                    ),
                    const Text('Masculino'),
                    Radio(
                      value: 'Femenino',
                      groupValue: selectedSexo,
                      onChanged: (value) {
                        setState(() {
                          selectedSexo = value.toString();
                        });
                      },
                    ),
                    const Text('Femenino'),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text('Fecha de Nacimiento'),
                Row(
                  children: [
                    Text(fechaNacimiento == null
                        ? 'Seleccione una fecha'
                        : '${fechaNacimiento!.day}/${fechaNacimiento!.month}/${fechaNacimiento!.year}'),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            fechaNacimiento = selectedDate;
                          });
                        }
                      },
                      child: const Text('Seleccionar Fecha'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text('Edad'),
                TextFormField(
                  controller: edadController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La edad es obligatoria';
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return 'Ingresa una edad válida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const Text('Estado Civil'),
                DropdownButtonFormField<String>(
                  value: selectedEstadoCivil,
                  items: const [
                    DropdownMenuItem(value: 'Soltero/a', child: Text('Soltero/a')),
                    DropdownMenuItem(value: 'Casado/a', child: Text('Casado/a')),
                    DropdownMenuItem(value: 'Divorciado/a', child: Text('Divorciado/a')),
                    DropdownMenuItem(value: 'Viudo/a', child: Text('Viudo/a')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedEstadoCivil = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selecciona tu estado civil';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Navegar al siguiente formulario
                          print('Datos validados, continuar al siguiente formulario.');
                        }
                      },
                      child: const Text('Siguiente'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Salir'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Enviar datos
                        print('Formulario enviado con éxito.');
                      }
                    },
                    child: const Text('Enviar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
