import { TestBed } from '@angular/core/testing';
import { SettingsService } from './settings.service';
import { TranslateService } from '@ngx-translate/core';
import { AppSettings, defaults } from '../settings';

describe('SettingsService', () => {
  let service: SettingsService;
  let mockTranslate: jasmine.SpyObj<TranslateService>;

  beforeEach(() => {
    mockTranslate = jasmine.createSpyObj('TranslateService', ['addLangs', 'use']);
    TestBed.configureTestingModule({
      providers: [SettingsService, { provide: TranslateService, useValue: mockTranslate }],
    });

    service = TestBed.inject(SettingsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should initialize with default language', () => {
    expect(mockTranslate.addLangs).toHaveBeenCalledWith(['en-US']);
    expect(mockTranslate.use).toHaveBeenCalledWith('en-US');
  });

  it('should return current options reflecting initial language', () => {
    // Tras la construcción, el servicio mezcla los defaults con initialLang 'en-US'
    expect(service.options.language).toBe('en-US');
    // Los demás valores por omisión permanecen igual
    const expectedOptions = { ...defaults, language: 'en-US' };
    expect(service.options).toEqual(expectedOptions);
  });

  it('should update options', (done) => {
    const newOptions: Partial<AppSettings> = { language: 'en-US' };
    service.setOptions(newOptions);
    service.notify$.subscribe((opts) => {
      expect(opts.language).toBe('en-US');
      done();
    });
  });

  it('should reset options to defaults', (done) => {
    service.setOptions({ theme: 'dark' });
    service.reset();
    service.notify$.subscribe((opts) => {
      expect(opts.theme).toBe(defaults.theme);
      done();
    });
  });

  it('should set theme class on <html>', () => {
    document.documentElement.classList.remove('theme-dark', 'theme-light');
    service.setOptions({ theme: 'dark' });
    service.setTheme();
    expect(document.documentElement.classList.contains('theme-dark')).toBeTrue();
  });

  it('should set text direction on <html>', () => {
    service.setOptions({ dir: 'rtl' });
    service.setDirection();
    expect(document.documentElement.dir).toBe('rtl');
  });

  it('should set language correctly', () => {
    mockTranslate.use.calls.reset();
    service.setLanguage('invalid');
    expect(mockTranslate.use).toHaveBeenCalledWith('en-US');
  });
});
