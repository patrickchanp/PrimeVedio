class SuperHero {
  // Init
  final String name;
  SuperHero({
    required this.name,
  });

  // toMap()
  Map<String, dynamic> toMap() {
    return {
      "name": name,
    };
  }

  // @override
  // String toString() {
  //   return "SuperHero{\n  id: $id\n  name: $name\n  age: $age\n  ability: $ability\n}\n\n";
  // }
}
