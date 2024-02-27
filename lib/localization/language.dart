abstract class Language {
  String get locale;

  String get appTitle;

  String get labelChapters;

  String get lang;

  String get noMore;

  String get loadingMore;

  String get search_settings;

  String get search_ai;

  String get readMore;

  String get readLess;

  String get shareText;

  String get shareHeader;

  String get share;
  String get addToFavourite;
  String get searchInAhadeeth;
  String get searchNumber;
  String get searchOption;
  String get searchOptionRelevance;
  String get searchOptionSimilar;
  String get searchSearch;
  String get searchSuggestedTopics;
  String get searchSearchSettings;
  String get searchSuggestedTopicsSubtext;
  String get sanadTitle;
  String get loading;
  String get fav;

  String get favTitle;
  String get errorSearch;
}

class Arabic implements Language {
  @override
  String get locale => "ar";

  @override
  String get appTitle => "أحاديث.AI";

  @override
  String get labelChapters => "كتب الأحاديث";

  @override
  String get lang => "English";

  @override
  String get noMore => "لم يتبقى أحاديت في هدا الكتاب";

  @override
  String get loadingMore => "جاري جلب المزيد من الحديث";

  @override
  String get search_settings => "إعدادات البحث";

  @override
  String get search_ai => "إبحث في الأحاديث بأستخدام الذكاء الإصطناعي";

  @override
  String get readLess => "إرجاع النص ";

  @override
  String get readMore => "إقرأ المزيد";
  String get share => "شارك الحديث";
  String get addToFavourite => "أضف للمفضلة";

  String get shareHeader => "أعجبني هذا الحديث المأخوذ من كتاب رياض الصالحين:";

  String get shareText =>
      "حمل تطبيق آحاديث.AI، وأحصل على الموشوعة الكاملة لكتاب رياض الصالحين من خلال الرابط:";

  @override
  String get searchInAhadeeth => "إبحث في الأحاديث";

  @override
  String get searchNumber => "عدد الأحاديث ";

  @override
  String get searchOption => "البحث حسب";

  @override
  String get searchOptionRelevance => "الملائمة";

  @override
  
  String get searchOptionSimilar => "التشابه";

  @override
  String get searchSearch => "إبحث الآن";

  @override
  String get searchSearchSettings => "إعدادات البحث";

  @override
  String get searchSuggestedTopics => "مواضيع مختارة";
  String get searchSuggestedTopicsSubtext => "أو إختر من المواضيع في الأسفل";
  String get sanadTitle => "سند الحديث (الرواة)";
  String get loading => "يتم إحضار الأحاديث، الرجاء الإنتظار";
  String get fav => "لا يوجد لديك أحاديث في قائمة المفضلة";
  String get favTitle => "الأحاديث مفضلة";
  String get errorSearch => "حدث خطأ أثناء البحث، لذلك قمنا بتقليص عدد النتائج";
}

class English implements Language {
  @override
  String get locale => "en";

  @override
  String get appTitle => "Ahadeeth.AI";

  @override
  String get labelChapters => "List of Chapters";

  @override
  String get lang => "عربي";

  @override
  String get noMore => "No More Ahadeeth left in this Chapter";

  @override
  String get loadingMore => "Loading More Hadeeth";

  @override
  String get search_settings => "Search Settings";

  @override
  String get search_ai => "Search Ahadeeth Using AI";

  @override
  String get readLess => "Read Less";

  @override
  String get readMore => "Read More";

  String get shareHeader => "I liked this Hadeeth form Ryiad Al-Salhien book:";

  String get share => "Share";
  String get addToFavourite => "Add to favourite";

  String get shareText =>
      "Download Ahadeeth.AI app, and get access to Ryiad Al-Salhien book, through this link:";


  @override
  String get searchInAhadeeth => "Search in all Ahadeeth";

  @override
  String get searchNumber => "Number of Ahadeeth";

  @override
  String get searchOption => "Search as";

  @override
  String get searchOptionRelevance => "Relevance";

  @override

  String get searchOptionSimilar => "Similar";

  @override
  String get searchSearch => "Search";

  @override
  String get searchSearchSettings => "Search Settings";

  @override
  String get searchSuggestedTopics => "Suggested Topics";
  String get searchSuggestedTopicsSubtext => "Or choose from below topics";
  String get sanadTitle => "Hadeeth Narrators (Sanad)";
  String get loading => "Loading Ahadeeth ";
  String get fav => "No Favourite Ahadeeth in the list";
  String get favTitle => "Favourite Ahadeeth";
  String get errorSearch => "Error with retrieving a lot of Ahadeeth, so we reduced the number of results";





}
