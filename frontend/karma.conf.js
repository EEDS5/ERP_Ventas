// karma.conf.js - Configuración profesional para Angular 19 en entorno empresarial

'use strict';

// Utiliza Puppeteer para obtener el ejecutable de Chrome de forma consistente
// Asegúrate de instalarlo: npm install puppeteer --save-dev
process.env.CHROME_BIN = require('puppeteer').executablePath();

module.exports = function(config) {
  const isCI = process.env.CI === 'true';

  config.set({
    // Base path para resolver patrones de archivos
    basePath: '',

    // Frameworks de test
    frameworks: ['jasmine', '@angular-devkit/build-angular'],

    // Plugins necesarios
    plugins: [
      require('@angular-devkit/build-angular/plugins/karma'),
      require('karma-jasmine'),
      require('karma-chrome-launcher'),
      require('karma-jasmine-html-reporter'),
      require('karma-coverage'),
      require('karma-spec-reporter')
    ],

    // Configuración del cliente
    client: {
      clearContext: false // mantiene la UI de resultados en el navegador
    },

    // Reporters de consola (specReporter)
    specReporter: {
      maxLogLines: 5,         // Límite de líneas por test
      suppressErrorSummary: false,
      suppressFailed: false,
      suppressPassed: true,
      suppressSkipped: true,
      showSpecTiming: true    // Muestra tiempo de ejecución de cada spec
    },

    // Reportes de cobertura de código
    coverageReporter: {
      dir: require('path').join(__dirname, './coverage/frontend-app'),
      reporters: [
        { type: 'html', subdir: 'html' },
        { type: 'text-summary' }
      ],
      check: {
        global: {
          statements: 80,
          branches: 80,
          functions: 80,
          lines: 80
        }
      }
    },

    // Reporters para UI y consola
    reporters: ['spec', 'progress', 'kjhtml'],

    // Puertos y logging
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,

    // Observación y reinicio en cambios
    autoWatch: !isCI,
    singleRun: isCI,

    // Concurrency de browsers
    concurrency: Infinity,

    // Lanzadores personalizados para Chrome
    customLaunchers: {
      ChromeHeadlessNoSandbox: {
        base: 'ChromeHeadless',
        flags: ['--no-sandbox', '--disable-gpu', '--disable-extensions', '--remote-debugging-port=9222']
      }
    },

    // Selección de browsers basada en entorno
    browsers: isCI ? ['ChromeHeadlessNoSandbox'] : ['Chrome']
  });
};
