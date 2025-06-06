export interface LanguageOption {
  code: string;
  labelKey: string;
}

export const SUPPORTED_LANGUAGES: LanguageOption[] = [
  { code: 'en-US', labelKey: 'language.english' },
  { code: 'es-ES', labelKey: 'language.spanish' },
  { code: 'zh-CN', labelKey: 'language.chinese_simplified' },
  { code: 'zh-TW', labelKey: 'language.chinese_traditional' },
];
