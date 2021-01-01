class Chat {
  final String name;
  final String message;
  final String time;
  final String id;
  final String avatar;

  Chat({this.name, this.message, this.time, this.id, this.avatar});

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      name: json['name'],
      id: json['id'],
      avatar: json['avatar'],
      message: json['message'],
      time: json['time'],
    );
  }

  static List<Chat> messages() {
    List dd = [
      {
        "id": "1",
        "avatar": "7YVZYZeITc8",
        "name": "Denny Hess",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "08:30am"
      },
      {
        "id": "2",
        "avatar": "mEZ3PoFGs_k",
        "name": "Adam Wyman",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "09:30pm"
      },
      {
        "id": "3",
        "avatar": "3TLl_97HNJo",
        "name": "Justin Smiths",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "06:40am"
      },
      {
        "id": "4",
        "avatar": "J1OScm_uHUQ",
        "name": "Sendi Madafaka",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "05:340pm"
      },
      {
        "id": "5",
        "avatar": "QXevDflbl8A",
        "name": "Justin Madafaka",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "05:340pm"
      },
      {
        "id": "6",
        "avatar": "X6Uj51n5CE8",
        "name": "Dolares Sancos",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "05:340pm"
      },
      {
        "id": "7",
        "avatar": "a6W4F62sN_yI",
        "name": "Durdi Sura",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "05:340pm"
      },
      {
        "id": "8",
        "avatar": "rriAI0nhcbc",
        "name": "Sonkara Dorsa",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "05:340pm"
      },
      {
        "id": "9",
        "avatar": "O3ymvT7Wf9U",
        "name": "Denny Hess",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "08:30am"
      },
      {
        "id": "10",
        "avatar": "B4TjXnI0Y2c",
        "name": "Adam Wyman",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "09:30pm"
      },
      {
        "id": "11",
        "avatar": "cdksyTqEXzo",
        "name": "Justin Smiths",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "06:40am"
      },
      {
        "id": "12",
        "avatar": "PQeoQdkU9jQ",
        "name": "Sendi Madafaka",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "05:340pm"
      },
      {
        "id": "13",
        "avatar": "8wbxjJBrl3k",
        "name": "Justin Madafaka",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "05:340pm"
      },
      {
        "id": "14",
        "avatar": "khV4fTy6-D8",
        "name": "Dolares Sancos",
        "message":
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Felanlar filanlar intermilanlar.",
        "time": "05:340pm"
      }
    ].map((e) {
      var vv = Chat.fromJson(e);
      return vv;
    }).toList();
    return dd;
  }
}