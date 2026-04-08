class StaticProduct {
  final String imageUrl;
  final String category;
  final String name;
  final double price;
  const StaticProduct(
      {required this.imageUrl,
      required this.category,
      required this.name,
      required this.price});
}

/******************** STATIC PRODUCTS **********************/
const List<StaticProduct> products = [
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=400',
      category: 'عطور رجالية',
      name: 'عطر الملك الفاخر',
      price: 299),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=400',
      category: 'عطور رجالية',
      name: 'خشب الصندل الملكي',
      price: 349),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400',
      category: 'عطور رجالية',
      name: 'عطر الأمير',
      price: 259),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1541643600914-78b084683702?w=400',
      category: 'عطور رجالية',
      name: 'مسك الليل',
      price: 189),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?w=400',
      category: 'عطور رجالية',
      name: 'البخور الملكي',
      price: 220),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1608528577891-eb055944f2e7?w=400',
      category: 'عطور رجالية',
      name: 'عطر الصحراء',
      price: 275),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1541643600914-78b084683702?w=400',
      category: 'عطور نسائية',
      name: 'ورد الملكة',
      price: 249),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1590439471364-192aa70c0b53?w=400',
      category: 'عطور نسائية',
      name: 'زهرة الياسمين',
      price: 219),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400',
      category: 'عطور نسائية',
      name: 'ليلى الفاخرة',
      price: 289),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1608528577891-eb055944f2e7?w=400',
      category: 'عطور نسائية',
      name: 'نور الصباح',
      price: 179),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1619994403073-2cec844b8e63?w=400',
      category: 'عطور نسائية',
      name: 'عبير الورود',
      price: 235),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=400',
      category: 'عطور نسائية',
      name: 'سحر الأنثى',
      price: 265),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      category: 'عطور الجسم',
      name: 'كريم العود',
      price: 149),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1619994403073-2cec844b8e63?w=400',
      category: 'عطور الجسم',
      name: 'زيت الورد',
      price: 129),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1590439471364-192aa70c0b53?w=400',
      category: 'عطور الجسم',
      name: 'بخاخ الجسم الذهبي',
      price: 99),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=400',
      category: 'عطور الشعر',
      name: 'زيت الشعر بالعود',
      price: 119),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400',
      category: 'عطور الشعر',
      name: 'بخاخ الشعر المعطر',
      price: 89),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?w=400',
      category: 'المكياج',
      name: 'أحمر الشفاه الذهبي',
      price: 79),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=400',
      category: 'المكياج',
      name: 'كونسيلر فاخر',
      price: 99),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?w=400',
      category: 'المكياج',
      name: 'باليت العيون',
      price: 149),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=400',
      category: 'العناية بالشعر',
      name: 'شامبو جوز الهند',
      price: 89),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400',
      category: 'العناية بالشعر',
      name: 'بلسم الأرغان',
      price: 99),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      category: 'العناية بالبشرة',
      name: 'كريم الوجه بالعود',
      price: 159),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=400',
      category: 'العناية بالبشرة',
      name: 'سيروم الذهب',
      price: 199),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      category: 'العناية بالجسم',
      name: 'سكراب الجسم بالعود',
      price: 139),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1590439471364-192aa70c0b53?w=400',
      category: 'العناية بالجسم',
      name: 'زبدة الجسم',
      price: 119),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?w=400',
      category: 'العود الطبيعي',
      name: 'عود هندي طبيعي',
      price: 599),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=400',
      category: 'العود الطبيعي',
      name: 'عود كمبودي فاخر',
      price: 799),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=400',
      category: 'العود الطبيعي',
      name: 'عود برونيي أصيل',
      price: 699),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?w=400',
      category: 'العود المحسن',
      name: 'عود بالمسك',
      price: 449),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=400',
      category: 'العود المحسن',
      name: 'عود بالورد',
      price: 399),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=400',
      category: 'العود المحسن',
      name: 'عود بالعنبر',
      price: 479),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?w=400',
      category: 'العود المحسن',
      name: 'عود الملوك المحسن',
      price: 549),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?w=400',
      category: 'عطور رجالية',
      name: 'عطر النخيل',
      price: 229),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?w=400',
      category: 'العود الطبيعي',
      name: 'مجموعة العود الكاملة',
      price: 699),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400',
      category: 'عطور نسائية',
      name: 'عطر الغروب',
      price: 245),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1608528577891-eb055944f2e7?w=400',
      category: 'العود المحسن',
      name: 'زيت البخور',
      price: 169),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      category: 'العناية بالجسم',
      name: 'كريم اليدين',
      price: 69),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=400',
      category: 'عطور رجالية',
      name: 'عطر الفجر',
      price: 279),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?w=400',
      category: 'العود الطبيعي',
      name: 'زيت العود الثمين',
      price: 499),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1541643600914-78b084683702?w=400',
      category: 'عطور نسائية',
      name: 'عطر الزهور',
      price: 209),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1590439471364-192aa70c0b53?w=400',
      category: 'عطور الجسم',
      name: 'بودرة العطر',
      price: 119),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?w=400',
      category: 'عطور نسائية',
      name: 'عطر الندى',
      price: 239),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=400',
      category: 'العناية بالشعر',
      name: 'سيروم الشعر',
      price: 95),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1619994403073-2cec844b8e63?w=400',
      category: 'عطور رجالية',
      name: 'عطر التمر',
      price: 259),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      category: 'العناية بالبشرة',
      name: 'كريم الليل',
      price: 149),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400',
      category: 'عطور نسائية',
      name: 'عطر الحرير',
      price: 289),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1608528577891-eb055944f2e7?w=400',
      category: 'العناية بالبشرة',
      name: 'مجموعة العناية',
      price: 299),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?w=400',
      category: 'العود الطبيعي',
      name: 'عود الجبل',
      price: 649),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=400',
      category: 'عطور رجالية',
      name: 'عطر البحر',
      price: 219),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1541643600914-78b084683702?w=400',
      category: 'عطور نسائية',
      name: 'ظل الورد',
      price: 255),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1590439471364-192aa70c0b53?w=400',
      category: 'العناية بالجسم',
      name: 'غسول اللوز',
      price: 85),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=400',
      category: 'عطور رجالية',
      name: 'عطر القهوة',
      price: 269),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1619994403073-2cec844b8e63?w=400',
      category: 'عطور الجسم',
      name: 'زيت اللوز',
      price: 109),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?w=400',
      category: 'عطور رجالية',
      name: 'بخاخ العطر الذهبي',
      price: 199),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=400',
      category: 'عطور رجالية',
      name: 'عطر الخشب',
      price: 319),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400',
      category: 'عطور نسائية',
      name: 'زهر البرتقال',
      price: 229),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      category: 'العناية بالبشرة',
      name: 'ماء الورد الفاخر',
      price: 75),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1608528577891-eb055944f2e7?w=400',
      category: 'عطور نسائية',
      name: 'عطر الفانيلا',
      price: 235),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?w=400',
      category: 'العود الطبيعي',
      name: 'عود الملك النادر',
      price: 950),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=400',
      category: 'عطور رجالية',
      name: 'مجموعة العطور الكاملة',
      price: 599),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=400',
      category: 'عطور رجالية',
      name: 'عطر الفخامة المطلقة',
      price: 499),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1547887538-e3a2f32cb1cc?w=400',
      category: 'العود المحسن',
      name: 'عود الأجداد',
      price: 750),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1541643600914-78b084683702?w=400',
      category: 'عطور رجالية',
      name: 'عطر الربيع',
      price: 210),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1590439471364-192aa70c0b53?w=400',
      category: 'عطور نسائية',
      name: 'عطر الأقحوان',
      price: 185),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1608528577891-eb055944f2e7?w=400',
      category: 'العناية بالجسم',
      name: 'زيت التدليك',
      price: 99),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
      category: 'العناية بالشعر',
      name: 'ماسك الشعر الذهبي',
      price: 129),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=400',
      category: 'المكياج',
      name: 'فرشاة التأسيس',
      price: 69),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1619994403073-2cec844b8e63?w=400',
      category: 'عطور نسائية',
      name: 'عطر الخزامى',
      price: 245),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=400',
      category: 'العود الطبيعي',
      name: 'عود صيني نادر',
      price: 899),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?w=400',
      category: 'عطور رجالية',
      name: 'عطر الياقوت',
      price: 380),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400',
      category: 'عطور نسائية',
      name: 'عطر الكابتشينو',
      price: 195),
  StaticProduct(
      imageUrl:
          'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=400',
      category: 'عطور رجالية',
      name: 'عطر الأرز',
      price: 310),
];
