class Language{

  int id;
  String flag;
  String name;
  String langCode;

  Language(this.id, this.flag, this.name, this.langCode);

  static List<Language> listLanguage() {
    return <Language> [
      Language( 1 ,'🇾🇪','عربي','ar'),
      Language( 2 ,'🇺🇸','English','en')
    ];
  }


}