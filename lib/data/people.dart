//* 1. Kelas Person
class Person{
  final String name;
  final String phone;
  final String picture;
  const Person(this.name,this.phone,this.picture);
}

//* 2. Variabel List dengan nama people yang memiliki data bertipe object Person, yang merupakan
//* hasil mapping data list pada baris 14 kebawah
final List<Person> people =
      _people.map((e) => Person(e['name'] as String, e['phone'] as String, e['picture'] as String)).toList(growable: false);

final List<Map<String,Object>> _people = 
[
  {
    "_id": "6506d3bed2354926924728c1",
    "index": 0,
    "guid": "9cd8f73e-75fb-414a-bdfb-49ca602abfde",
    "isActive": false,
    "balance": "\$3,611.61",
    "picture": "http://placehold.it/32x32",
    "age": 25,
    "eyeColor": "brown",
    "name": "Allie Fleming",
    "gender": "female",
    "company": "KANGLE",
    "email": "alliefleming@kangle.com",
    "phone": "+1 (804) 419-3178",
    "address": "295 Marconi Place, Rosewood, Oregon, 8922",
    "about": "Commodo anim non ad proident sit eu officia. Ea cillum magna adipisicing sit voluptate sint exercitation id enim. Sunt amet aliqua adipisicing est proident excepteur laborum exercitation magna nostrud sit Lorem. Commodo do consectetur commodo laboris ex. Dolor veniam ipsum veniam quis consectetur. Enim id cupidatat laboris laboris nisi reprehenderit est ea sit. Laboris esse aliqua nostrud eu elit ad nostrud cupidatat id sint.\r\n",
    "registered": "2015-09-22T07:04:41 -07:00",
    "latitude": -79.180593,
    "longitude": -65.121699,
    "tags": [
      "occaecat",
      "ullamco",
      "dolore",
      "veniam",
      "mollit",
      "nulla",
      "id"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Lopez Walsh"
      },
      {
        "id": 1,
        "name": "West Brown"
      },
      {
        "id": 2,
        "name": "Kenya Haley"
      }
    ],
    "greeting": "Hello, Allie Fleming! You have 3 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "6506d3be421629358f8fe0fd",
    "index": 1,
    "guid": "26e1999e-76da-4cf8-be80-2cf783c40717",
    "isActive": false,
    "balance": "\$3,355.54",
    "picture": "http://placehold.it/32x32",
    "age": 23,
    "eyeColor": "blue",
    "name": "Carrie Peterson",
    "gender": "female",
    "company": "EGYPTO",
    "email": "carriepeterson@egypto.com",
    "phone": "+1 (914) 573-3823",
    "address": "871 Grand Street, Forbestown, Arizona, 2008",
    "about": "Laborum occaecat aute aliquip consequat. Laborum eiusmod mollit ex culpa laboris. Velit ea anim cupidatat occaecat exercitation esse laborum esse. Pariatur laboris quis commodo ad qui consequat reprehenderit Lorem consequat excepteur aliquip. In ex laboris laborum consectetur consectetur deserunt laboris dolore officia excepteur aliquip reprehenderit id. Elit minim est in sunt eiusmod.\r\n",
    "registered": "2023-07-22T09:56:08 -07:00",
    "latitude": 44.935864,
    "longitude": -41.42682,
    "tags": [
      "est",
      "sunt",
      "consectetur",
      "do",
      "laboris",
      "esse",
      "duis"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Navarro Copeland"
      },
      {
        "id": 1,
        "name": "Britney Livingston"
      },
      {
        "id": 2,
        "name": "Hancock Hendricks"
      }
    ],
    "greeting": "Hello, Carrie Peterson! You have 3 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "6506d3be26f6fdf0cacbdbac",
    "index": 2,
    "guid": "74d76ac0-6b2a-4188-a1af-b56985d1b7e9",
    "isActive": true,
    "balance": "\$1,506.88",
    "picture": "http://placehold.it/32x32",
    "age": 36,
    "eyeColor": "blue",
    "name": "Lou Stephens",
    "gender": "female",
    "company": "GOGOL",
    "email": "loustephens@gogol.com",
    "phone": "+1 (834) 479-3529",
    "address": "989 Rochester Avenue, Weedville, Montana, 4058",
    "about": "Qui irure minim et qui adipisicing pariatur voluptate ea id non qui velit. Sunt excepteur ex ex pariatur. Ipsum velit ipsum nulla tempor anim aute est ipsum velit do sit eu qui ipsum. Id ex qui magna id laboris consequat minim nostrud deserunt. Consequat anim occaecat elit nostrud Lorem et dolore exercitation est reprehenderit cillum fugiat et. Commodo sunt qui officia nisi aliqua consequat est exercitation veniam quis do aute nulla ut. Tempor esse adipisicing est do.\r\n",
    "registered": "2015-11-09T03:24:58 -07:00",
    "latitude": -1.142676,
    "longitude": 143.97367,
    "tags": [
      "occaecat",
      "officia",
      "ut",
      "proident",
      "ut",
      "irure",
      "proident"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Holder Herring"
      },
      {
        "id": 1,
        "name": "Patricia Pate"
      },
      {
        "id": 2,
        "name": "Allison Odom"
      }
    ],
    "greeting": "Hello, Lou Stephens! You have 6 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "6506d3be8b7b9517ffd1a21d",
    "index": 3,
    "guid": "b77be5c3-eca1-4058-b8ac-f458270411e4",
    "isActive": true,
    "balance": "\$3,254.04",
    "picture": "http://placehold.it/32x32",
    "age": 20,
    "eyeColor": "green",
    "name": "Spence Gentry",
    "gender": "male",
    "company": "MANGLO",
    "email": "spencegentry@manglo.com",
    "phone": "+1 (877) 404-2671",
    "address": "883 Interborough Parkway, Dana, Pennsylvania, 224",
    "about": "Enim enim irure excepteur duis incididunt dolore duis incididunt minim. Commodo laboris sunt aliqua est pariatur consectetur et dolor ex nulla occaecat enim. Nisi consequat eu pariatur enim deserunt enim anim laborum laboris anim incididunt. Enim laborum eu occaecat ea eu laborum in irure sit ullamco amet.\r\n",
    "registered": "2019-10-29T06:39:06 -07:00",
    "latitude": 85.53911,
    "longitude": 157.625638,
    "tags": [
      "anim",
      "velit",
      "qui",
      "amet",
      "amet",
      "veniam",
      "id"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Selena Mclean"
      },
      {
        "id": 1,
        "name": "Jordan Bonner"
      },
      {
        "id": 2,
        "name": "Baker Beasley"
      }
    ],
    "greeting": "Hello, Spence Gentry! You have 2 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "6506d3be13164467ae2e9485",
    "index": 4,
    "guid": "ceac4411-a940-41d0-a711-6fb189367803",
    "isActive": false,
    "balance": "\$1,788.53",
    "picture": "http://placehold.it/32x32",
    "age": 23,
    "eyeColor": "brown",
    "name": "Paige Dudley",
    "gender": "female",
    "company": "MOMENTIA",
    "email": "paigedudley@momentia.com",
    "phone": "+1 (868) 485-2399",
    "address": "707 Ridgecrest Terrace, Kipp, Iowa, 2536",
    "about": "Cupidatat exercitation deserunt laboris incididunt nulla magna irure cillum non veniam. Laboris veniam ipsum nisi ipsum anim voluptate ea tempor duis non sunt est. Ea elit enim cupidatat velit excepteur anim magna culpa mollit aliquip. Dolor aliquip excepteur nostrud consectetur magna. Ullamco est pariatur nisi cillum ex id sint eiusmod cupidatat dolore aute magna culpa. Nisi eu ut aliquip id dolore duis amet.\r\n",
    "registered": "2019-05-02T04:20:56 -07:00",
    "latitude": 16.296394,
    "longitude": -161.647422,
    "tags": [
      "deserunt",
      "ipsum",
      "consectetur",
      "dolore",
      "cupidatat",
      "Lorem",
      "tempor"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Schneider Rojas"
      },
      {
        "id": 1,
        "name": "Beck Lee"
      },
      {
        "id": 2,
        "name": "Velma Serrano"
      }
    ],
    "greeting": "Hello, Paige Dudley! You have 5 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "6506d3be4447ac8e0affb58a",
    "index": 5,
    "guid": "56ea6a41-7745-4c5a-89af-9f060d73fb07",
    "isActive": true,
    "balance": "\$2,470.94",
    "picture": "http://placehold.it/32x32",
    "age": 37,
    "eyeColor": "green",
    "name": "Andrea Woodward",
    "gender": "female",
    "company": "PUSHCART",
    "email": "andreawoodward@pushcart.com",
    "phone": "+1 (921) 436-3795",
    "address": "250 Granite Street, Flintville, Oklahoma, 9881",
    "about": "Magna excepteur sunt aliqua cillum nostrud eiusmod eiusmod ex sint fugiat laboris. Nisi id id cupidatat elit laboris aute. Occaecat excepteur cillum deserunt ex minim do.\r\n",
    "registered": "2021-02-13T11:23:52 -07:00",
    "latitude": -0.572406,
    "longitude": 88.581969,
    "tags": [
      "non",
      "commodo",
      "ut",
      "aliquip",
      "Lorem",
      "esse",
      "adipisicing"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Casey Ashley"
      },
      {
        "id": 1,
        "name": "Nina Buck"
      },
      {
        "id": 2,
        "name": "Kirk Vargas"
      }
    ],
    "greeting": "Hello, Andrea Woodward! You have 9 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
      "_id": "640cab644865c6302804d578",
      "index": 0,
      "guid": "aafaebf8-94e6-4e97-9473-378a412e9df3",
      "isActive": true,
      "balance": "\$3,574.12",
      "picture": "http://placehold.it/32x32",
      "age": 32,
      "eyeColor": "green",
      "name": "Blanche Pena",
      "gender": "female",
      "company": "ZEDALIS",
      "email": "blanchepena@zedalis.com",
      "phone": "+1 (969) 480-2481",
      "address": "917 Heyward Street, Hasty, Arizona, 7612",
      "about": "Deserunt non laboris sit qui voluptate excepteur pariatur sunt non sit. Commodo eu esse incididunt qui. Nisi ex est es official",
      "registered": "2022-0-03T03:14:34 -07:00",
    }
];