final Map<String, String> esCo = {
  // Splash page
  'splash_page_1':
      'Bienvenido a la aplicación de gestión de tus dispositivos IoT de IoBix',
  'splash_page_2':
      'Descubre y conéctate a tus dispositivos IoT cercanos mediante tu interface Bluetooth',
  'splash_page_3':
      'Revisa el estado actual y establece las configuraciones necesarias a cada dispositivo IoT',

  // Login page
  'sign_continue': 'Incia sesión para continuar',
  'check_user': 'Ups!, verifique sus credenciales',

  // Home Page
  // Bluetooth Card Widget
  'ble_card_title': 'Conéctate a un dispositivo',
  'ble_card_content':
      '¿No encuentras tu dispositivo?. Verifica que su interface Bluetooth esté habilitada',
  'ble_card_off': '¡Ups!, verifica tu interface ',
  'ble_card_turning_on':
      '¡Perfecto!, se esta iniciando la interface Bluetooth ...',
  'ble_card_connecting':
      '¡A trabajar!, estamos intentando conectarnos al dispositivo IoT',
  'ble_card_scanning':
      '¡Ok!, estamos descubriendo los dispositivos Bluetooth cercanos ...',
  'ble_card_error': '¡Ups!, ha ocurrido algo inesperado: ',
  'ble_card_start_scan': 'Iniciar búsqueda',
  'ble_card_turning_off':
      '¡Ups!, se esta desactivando tu interface Bluetooth ...',
  'ble_card_error_interface':
      '¡Ups!, al parecer hay un error con tu interface Bluetooth, intente solucionar el problema he intente nuevamente',
  // Bluetooth Devices List
  'ble_connect': 'Conectar',
  'ble_name_unknown': 'Dispositivo desconocido',
  'ble_type_vtg': 'Estación meteorológica',
  'ble_type_tmp': 'Sensor de temperatura',
  // Bluetooth try connect
  'ble_progress_idle': 'Conexión iniciada',
  'ble_progress_connecting': 'Conectado al dispositivo',
  'ble_progress_check_services': 'Verificación de servicios',
  'ble_progress_check_compatibility':
      'Verificación de compatibilidad con la aplicación',
  'ble_progress_connected':
      '¡Perfecto!, conexión establecida, será redirigido en unos instantes',
  // Bluetooth error connect
  'ble_error_compatibility':
      'El dispositivo no es compatible con la aplicación',
  'ble_error_already_connected': 'La conexión con este dispositivo ya existe',
  'ble_error_timeout': 'Se agoto el tiempo',
  'ble_error_unknown': 'Error desconocido',
  // Home Drawer
  'drawer_devices': 'Dispositivos compatibles',
  'drawer_about': 'Sobre nosotros',

  //Configuration page
  'select_lang': 'Seleccione un idioma',

  // Device page
  'ble_colbits_device': 'Dispositivo IoBix',
  'ble_disconnect_alert_msg':
      'Se va a desconectar del dispositivo, ¿Desea continuar?',
  'floating_console': 'Consola flotante',
  'device_security': 'Seguridad del dispositivo',
  'device_version_error':
      'Error en la versión del dispositivo o no hay parámetros específicos para visualizar ...',
  'no_specific_settings': 'No hay configuraciones específicas ...',
  'enter_password': 'Ingrese una contraseña',
  'error_apilogin_2':
      '¡Ups!, no logramos verificar la contraseña, te quedan 2 intentos',
  'error_apilogin_1':
      '¡Ups!, no logramos verificar la contraseña, te queda un intento. Si vuelves a fallar tendremos que desconectarnos del dispositivo',
  'error_apilogin_len': 'La contraseña debe ser de 4 caracteres',

  'req_snackbar': '¡A trabajar!',
  'req_snackbar_msg_common': 'Vamos a enviar tu solicitud: (Espera un momento)',

  'res_snackbar_ok': '¡Hecho!',
  'res_snackbar_ok_msg_common':
      'El dispositivo ha procesado correctamente tu solicitud:',

  'res_snackbar_err': '¡Ups!',
  'res_snackbar_err_msg_common':
      'El dispositivo tuvo problemas procesando tu solicitud: (Intente nuevamente)',
  'res_snackbar_err_msg_app':
      'Esta aplicación no es compatible con tu solicitud: (Verifica que tengas la última versión instalada)',
  'res_snackbar_err_msg_rak_bug':
      'El dispositivo podría tardar hasta 1 minuto en procesar tu solicitud: (Por favor espera un momento, te avisaremos cuando sea proceseda)',
  'res_snackbar_err_msg_set_rtc':
      'La fecha que quieres establecer debe ser mayor a la del dispositivo, verifica e intenta nuevamente',
  'res_snackbar_err_msg_0x01':
      'El dispositivo se encuentra ocupado, tu solicitud no pudo ser atendida: (Intente más tarde)',
  'res_snackbar_err_msg_0x04': 'Tu solicitud no existe para este dispositivo:',
  'res_snackbar_err_msg_0x05':
      'El dispositivo excedio el tiempo permitido para atender tu solicitud: (Intente nuevamente)',
  'res_snackbar_err_msg_0x06':
      'El dispositivo no es compatible o no cuenta con las caracteristicas de tu solicitud:',

  'snackbar_reset': 'Reiniciar el dispositivo',
  'snackbar_buzzer': 'Prueba del Buzzer',
  'snackbar_leds': 'Configurar LEDs',
  'snackbar_acel': 'Configurar acelerómetro',
  'snackbar_gnss': 'Configurar GPS',
  'snackbar_measure_time': 'Configurar tiempo de medición',
  'snackbar_tx_time': 'Configurar tiempo de envio LoRa',
  'snackbar_healthy_report': 'Reporte de salud',
  'snackbar_set_rtc': 'Configurar reloj interno',
  'snackbar_confirmed_msgs': 'Configurar mensajes confirmados LoRa',
  'snackbar_set_password': 'Configurar contraseña',
  'snackbar_clear_logapp': 'Eliminar memoria de aplicación',
  'snackbar_clear_logsys': 'Eliminar memoria del sistema',
  'snackbar_test_tx_lora': 'Prueba de envio LoRa',
  'snackbar_set_radiostack': 'Configurar parámetros LoRa',
  'snackbar_set_forwardings': 'Configurar retransmisiones LoRa',
  'snackbar_set_lora_sub_bands': 'Configurar canales LoRa',
  'snackbar_set_lora_data_rate': 'Configurar factor de difusión LoRa',
  'snackbar_set_lora_tx_power': 'Configurar potencia de transmisión LoRa',
  'snackbar_set_lora_adr': 'Configurar tasa adaptativa de datos LoRa',
  'snackbar_set_lora_duty_cycle': 'Configurar ciclo de trabajo LoRa',
  'snackbar_set_lora_class': 'Configurar clase LoRa',
  'snackbar_set_lora_band': 'Configurar región LoRa',
  'snackbar_set_lora_oper_mode': 'Configurar modo de operación LoRa',
  'snackbar_get_lora_rak_info': 'Obtener parámetros LoRa',
  'snackbar_get_lora_sub_bands': 'Obtener canales LoRa',
  'snackbar_get_lora_data_rate': 'Obtener factor de difusión LoRa',
  'snackbar_get_lora_tx_power': 'Obtener potencia de transmisión LoRa',
  'snackbar_get_lora_adr': 'Obtener tasa adaptativa de datos LoRa',
  'snackbar_get_lora_duty_cycle': 'Obtener ciclo de trabajo LoRa',
  'snackbar_get_lora_class': 'Obtener clase LoRa',
  'snackbar_get_lora_band': 'Obtener región LoRa',
  'snackbar_get_lora_oper_mode': 'Obtener modo de operación LoRa',

  // LoRaWAN tab
  'len_error_lora_key': 'La credencial debe ser de %s bytes',
  'radio_info': 'Información de radio',
  'oper_band': 'Banda de operación',
  'sub_band': 'Sub-banda %s',
  'spread_factor': 'Factor de difusión',
  'tx_power': 'Potencia de transmisión',
  'lora_adr': 'Tasa adaptativa',
  'duty_cycle': 'Ciclo de trabajo',
  'connect_net?': '¿Conectado a la red?',
  'module_info': 'Información del módulo',
  'oper_mode': 'Modo de operación',
  'connect_mode': 'Modo de conexión',
  'x_param': 'Parámetros %s',
  'x_active': 'Activación %s',
  'select_oper_mode': 'Seleccione el modo de operación del módulo lora',
  'select_oper_band': 'Seleccione la banda de operación del módulo lora',
  'select_sub_band': 'Seleccione la sub-banda %s de operación del módulo lora',
  'select_spread_factor': 'Seleccione el factor de difusión del módulo lora',
  'select_class': 'Seleccione la clase lora del dispositivo',
  // System tab
  'confirmed_msgs': 'Mensajes confirmados',
  'closed_device': 'Dispositivo cerrado',
  'open_device': 'Dispositivo abierto',
  'fall_alarm': 'Alarma de caída',
  'device_tampering': 'Manipulación del dispositivo',
  'solar_panel': 'Panel solar',
  'aux_voltage': 'Voltaje auxiliar',
  'device_info': 'Información del dispositivo',
  'memory_clear_msg':
      'Se van a eliminar todos los datos almacenados en la memoria instalada, ¿Desea continuar?',
  'memory_clear_logsys_msg':
      '!Hola Admin¡, se van a eliminar todos los eventos (logs del sistema) almacenados en la memoria instalada, ¿Desea continuar?',
  'memory_block': 'Bloque de memoria',
  'select_memory_block': 'Seleccione el bloque de memoria a leer',
  'event_type': 'Tipo de evento',
  'select_event_type': 'Seleccione el tipo de evento a leer',
  'date_range': 'Rango de fechas',
  'reading_memory':
      'A trabajar!, estamos examinando los registros almacenados en memoria',
  'data_found': 'Datos encontrados',
  'data_not_found_msg':
      'Ups!, no logramos encontrar ningún dato en el rango solicitado',
  'finish_read_memory':
      'Listo!, hemos encontrado %s dato(s), ¿Qué hacemos ahora?',
  'see_data_console': 'Ver datos en consola',
  'share_file': 'Compartir archivo',
  'read_data': 'Leer datos',
  'device_data': 'Datos del dispositivo',
  'system_data': 'Datos del sistema',
  'all_events': 'Todos los eventos',
  'general_system_event': 'Evento general del sistema',
  'ble_event': 'Evento del módulo Bluetooth',
  'memory_event': 'Evento de la memoria',
  'lora_event': 'Evento del módulo LoRa',
  'gnss_event': 'Evento del GNSS',
  'specific_device_event': 'Evento específico del dispositivo',
  'measure_time': 'Periodo de medición',
  'tx_time': 'Periodo de transmisión',
  'hex_format': 'Formato hexadecimal',
  'announcement_name': 'Nombre de anunciamiento',
  'old_password': 'Contraseña vieja',
  'new_password': 'Nueva contraseña',
  // Memory file
  'firmware_version': 'Versión de firmware',
  'ble_api_version': 'Versión del API BLE',
  'device_id': 'Identificador de dispositivo',
  'app_version': 'Versión de la aplicación',
  'req_info': 'Información de solicitud',
  'data_extr_date': 'Fecha de extracción de datos',
  'init_read_date': 'Fecha inicial de lectura',
  'final_read_date': 'Fecha final de lectura',
  'frame_format': 'Formato de trama',
  'frame_format_logsys':
      '[Fecha del registro] - [Tipo de evento] - [Sub tipo de evento] - [Datos del evento]',
  'frame_format_logapp':
      '[Fecha del registro] - [ID del mensaje] - [Tipo de evento] - [Sub tipo de evento] - [Datos del evento]',
  'code_error': 'Error de código',
  'subtype_error': 'Error del subtipo de evento',
  'set_measure_time': 'Configuración del periodo de medición',
  'set_tx_time': 'Configuración del periodo de transmisión',
  'set_hw_id': 'Configuración del identificador de hardware',
  'set_rtc': 'Configuración del RTC',
  'set_ble_name': 'Configuración del nombre de anunciamiento',
  'failed_loginapi': 'Intento fallido de ingreso al API',
  'password_modifiy': 'Modificación de contraseña',
  'admin_password_modify': 'Modificación forzada de contraseña',
  'lora_config': 'Configuración de parámetros LoRa',
  'tx_error': 'Error en una transmisión',
  'set_rtc_server': 'Configuración del RTC por servidor',
  'req_tx_test': 'Solicitud de transmisión de prueba',

  // Vantage Logger
  'rain_gauge_alarm': 'Alarma de bloqueo del pluviometro',
  // Temperature Logger
  'digital_sensor': 'Sensor digital',
  'complementary_sensors': 'Sensores complementarios',
  'select_digital_sensor': 'Seleccione el sensor digital instalado',
  'alarm_parameters': 'Parámetros de alarmas',
  'set_all': 'Establecer para todos',
  'what_sensor_set': '¿Qué sensor desea configurar',
  'lower_threshold': 'Umbral inferior',
  'upper_threshold': 'Umbral superior',
  'alarm_temperature_config':
      'Configuración de parámetros para alarmas de temperatura',
  'alarm_temperature': 'Alarma de temperatura',
  'max_threshold_error': 'El umbral superior debe ser mayor al inferior',
  'no_sensor_select_error': 'Aún no selecciona ningún sensor',
  'snackbar_get_temp_alarm_param': 'Obtener parámetros de las alarmas',
  'snackbar_set_temp_alarm_param': 'Configurar parámetros de las alarmas',
  'snackbar_set_digital_sensor': 'Configurar sensor digital',
  'm_last_sensor_status': 'Estado del sensor en la última medición',
  // Common
  'raw_app_data': 'Datos crudos de aplicación',
  'sensor_disconnected': 'Sensor desconectado',
  'superadmin_role': 'Administrador de Colbits',
  'admin_role': 'Administrador de dispositivos',

  // Simple
  'disconnected': 'Desconectado',
  'continue': 'Continuar',
  'welcome': 'Bienvenido',
  'user': 'Usuario',
  'password': 'Contraseña',
  'login': 'Ingresar',
  'admin': 'Administrador',
  'discover': 'Descubre',
  'config': 'Configuración',
  'logout': 'Cerrar sesión',
  'language': 'Idioma',
  'spanish': 'Español',
  'english': 'Inglés',
  'alert_title': '¡Atención!',
  'select': 'Seleccione',
  'yes': 'Si',
  'no': 'No',
  'device': 'Dispositivo',
  'system': 'Sistema',
  'console': 'Consola',
  'registers': 'Registros',
  'characters': 'Caracteres',
  'send': 'Enviar',
  'temperature': 'Temperatura',
  'set': 'Establecer',
  'wind': 'Viento',
  'humidity': 'Humedad',
  'precipitation': 'Precipitación',
  'radiation': 'Radiación',
  'index': 'Indice',
  'reset': 'Reiniciar',
  'tampering': 'Manipulación',
  'unsupported': 'Sin soporte',
  'motion': 'Movimiento',
  'orientation': 'Orientación',
  'active': 'Activa',
  'inactive': 'Inactiva',
  'battery': 'Batería',
  'periods': 'Periodos',
  'measure': 'Medición',
  'transmission': 'Transmisión',
  'clock': 'Reloj',
  'date': 'Fecha',
  'hour': 'Hora',
  'developer': 'Desarrollador',
  'version': 'Versión',
  'unknown': 'Desconocido',
  'memory': 'Memoria',
  'from': 'Desde',
  'to': 'Hasta',
  'seconds': 'Segundos',
  'minutes': 'Minutos',
  'identifier': 'Identificador',
  'maintenance': 'Mantenimiento',
  'name': 'Nombre',
  'security': 'Seguridad',
  'class': 'Clase',
  'default': 'Por defecto',
  'customer': 'Personalizado',
  'forwardings': 'Retransmisiones',
  'number': 'Número',
  'data': 'Datos',
  'enabled': 'Habilitada',
  'disabled': 'Deshabilitada',
  'activation': 'Activación',
  'synchronization': 'Sincronización',
  'None': 'Ninguno',
  'pressure': 'Presión',
  'information': 'Información',
  'coverage': 'Cobertura',

  // Error
  'format_error': 'Ingrese un formato válido',
  'empty_error': 'Ingrese un valor',
  'range_error': 'Ingrese un valor dentro del rango %s',
  'select_error': 'Seleccione un valor',
  'hex_format_error': 'Ingrese un formato hexadecimal',
  'len_error': 'El valor debe tener %s caracteres'
};
